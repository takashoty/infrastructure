resource "google_container_cluster" "gke_cluster" {
  name     = "kv-094-gke-cluster"
  project  = var.project
  location = var.location
  node_locations = ["europe-west3-a", "europe-west3-b", "europe-west3-c"]

  remove_default_node_pool = true
  initial_node_count       = 1

  network = var.vpc_name
  subnetwork = var.subnet_name
}

resource "google_container_node_pool" "gke_node_pool" {
  project    = var.project
  cluster    = google_container_cluster.gke_cluster.name
  node_locations = ["europe-west3-a", "europe-west3-b", "europe-west3-c"]
  location = google_container_cluster.gke_cluster.location
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = var.machine_type

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
