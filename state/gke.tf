////////////////////////////////////////
// GKE Kubernetes Cluster Definition
////////////////////////////////////////

resource "google_service_account" "gke_sa" {
  project = var.gcp_project
  account_id = "${var.gcp_project}-gke-sa"
  display_name = "${var.gcp_project}-gke-sa"
}

resource "google_project_iam_member" "gke_sa" {
  count = length(var.gke_iam_roles)
  project = var.gcp_project
  role = element(values(var.gke_iam_roles), count.index)
  member = "serviceAccount:${google_service_account.gke_sa.email}"
}

module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google//modules/beta-private-cluster"
  version                    = "13.0.0"
  project_id                 = var.gcp_project
  region                     = var.region
  regional                   = false
  zones                      = var.zones
  name                       = var.cluster_name
  network                    = var.vpc_name
  subnetwork                 = var.subnet_name

  logging_service            = "logging.googleapis.com/kubernetes"
  monitoring_service         = "monitoring.googleapis.com/kubernetes"

  ip_range_pods              = google_compute_subnetwork.project_subnet.secondary_ip_range[0].range_name
  ip_range_services          = google_compute_subnetwork.project_subnet.secondary_ip_range[1].range_name
  http_load_balancing        = false
  horizontal_pod_autoscaling = true
  network_policy             = true
  enable_private_endpoint    = true
  enable_private_nodes       = true
  kubernetes_version         = var.k8s_version
  master_global_access_enabled = false
  master_ipv4_cidr_block     = var.gke_master_cidr
  master_authorized_networks = [
    {
      display_name = "bastion",
      cidr_block = format("%s/32", google_compute_instance.bastion.network_interface.0.network_ip)
    }
  ]

  node_pools = [
    {
      name               = "pool01"
      machine_type       = var.gke_pool01_machines
      min_count          = 2
      max_count          = 3
      local_ssd_count    = 0
      disk_size_gb       = 100
      disk_type          = "pd-standard"
      image_type         = "COS"
      auto_repair        = true
      auto_upgrade       = true
      service_account    = google_service_account.gke_sa.email
      preemptible        = var.gke_pool01_preemptible
      initial_node_count = 2
    },
  ]

  node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/devstorage.read_only"
    ]
  }

  node_pools_labels = {
    all = {}

    pool01 = {
      pool01 = true
    }

  }

  node_pools_metadata = {
    all = {}

    pool01 = {
      metadata-value = "pool01"
    }
  }

  node_pools_taints = {
    all = []

    pool01 = [
      {
        key    = "pool01"
        value  = true
        effect = "PREFER_NO_SCHEDULE"
      },
    ]

  }

  node_pools_tags = {
    all = []

    pool01 = [
      "pool01",
    ]
  }
}
