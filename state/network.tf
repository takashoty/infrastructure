resource "google_compute_network" "project_network" {
  name = var.vpc_name
  project = var.gcp_project
  auto_create_subnetworks = false
  routing_mode = "REGIONAL"

  depends_on = [
    google_project_service.service,
  ]
}

resource "google_compute_subnetwork" "project_subnet" {
  name = var.subnet_name
  project = var.gcp_project
  region = var.region
  ip_cidr_range = var.subnet_cidr
  private_ip_google_access = true
  network = google_compute_network.project_network.self_link

  secondary_ip_range {
    range_name    = format("%s-pod-range", var.cluster_name)
    ip_cidr_range = var.subnet_pod_cidr
  }

  secondary_ip_range {
    range_name    = format("%s-svc-range", var.cluster_name)
    ip_cidr_range = var.subnet_service_cidr
  }
}

// Create an external NAT IP
resource "google_compute_address" "nat" {
  name    = format("%s-nat-ip", var.cluster_name)
  project = var.gcp_project
  region  = var.region

  depends_on = [
    google_project_service.service,
  ]
}

// Create a cloud router for use by the Cloud NAT
resource "google_compute_router" "router" {
  name    = format("%s-cloud-router", var.cluster_name)
  project = var.gcp_project
  region  = var.region
  network = google_compute_network.project_network.self_link

  bgp {
    asn = 64514
  }
}

// Create a NAT router so the nodes can reach DockerHub, etc
resource "google_compute_router_nat" "nat" {
  name    = format("%s-cloud-nat", var.cluster_name)
  project = var.gcp_project
  router  = google_compute_router.router.name
  region  = var.region

  nat_ip_allocate_option = "MANUAL_ONLY"

  nat_ips = [google_compute_address.nat.self_link]

  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork {
    name                    = google_compute_subnetwork.project_subnet.self_link
    source_ip_ranges_to_nat = ["PRIMARY_IP_RANGE", "LIST_OF_SECONDARY_IP_RANGES"]

    secondary_ip_range_names = [
      google_compute_subnetwork.project_subnet.secondary_ip_range[0].range_name,
      google_compute_subnetwork.project_subnet.secondary_ip_range[1].range_name,
    ]
  }
}

resource "google_compute_route" "project_default_internet_gateway" {
  project = var.gcp_project
  name        = "default-internet-gateway"
  dest_range  = "0.0.0.0/0"
  network     = google_compute_network.project_network.name
  next_hop_gateway = format("https://www.googleapis.com/compute/v1/projects/%s/global/gateways/default-internet-gateway", var.gcp_project)
  tags        = []
}

// Firewall rules
// Allow access to the Bastion Host via SSH
resource "google_compute_firewall" "bastion_ssh" {
  name          = format("%s-bastion-ssh", var.cluster_name)
  network       = google_compute_network.project_network.name
  direction     = "INGRESS"
  project       = var.gcp_project
  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = ["22", "443"]
  }

  target_tags = ["bastion"]
}

// // Allow master to connect to nodes. Cert-manager needs to communicate via 6443
// resource "google_compute_firewall" "access_master" {
//   name          = format("%s-access-master", var.cluster_name)
//   network       = google_compute_network.project_network.name
//   direction     = "INGRESS"
//   project       = var.gcp_project
//   source_ranges = [var.gke_master_cidr]
//   priority = 999
// 
//   allow {
//     protocol = "tcp"
//     ports    = ["6443"]
//   }
// 
//   target_tags = [format("gke-%s", var.cluster_name)]
// }

resource "google_compute_firewall" "access_master_pod" {
  name          = format("%s-access-master", var.cluster_name)
  network       = google_compute_network.project_network.name
  direction     = "INGRESS"
  project       = var.gcp_project
  source_ranges = [var.gke_master_cidr]
  priority = 999

  allow {
    protocol = "tcp"
    ports    = ["8443"]
  }

  target_tags = [format("gke-%s", var.cluster_name)]
}
