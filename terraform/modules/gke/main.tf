data "google_client_config" "provider" {}

data "google_container_cluster" "gke_cluster" {
  name = "kv094-cluster"
  location = var.location
}

provider "kubernetes" {
  host = "https://${data.google_container_cluster.gke_cluster.endpoint}"
  token = data.google_client_config.provider.access_token
  cluster_ca_certificate = base64decode(
          data.google_container_cluster.gke_cluster.master_auth[0].cluster_ca_certificate,
  )
}

resource "google_container_cluster" "gke_cluster" {
  name     = "kv094-cluster"
  project  = var.project
  location = var.location
  //  node_locations = ["europe-west3-a", "europe-west3-b", "europe-west3-c"]
  node_locations = ["europe-west3-a"]

  remove_default_node_pool = true
  initial_node_count       = 1

  master_auth {
    # Setting an empty username and password explicitly disables basic auth
    username = ""
    password = ""
  }

  network    = var.vpc_name
  subnetwork = var.subnet_name
}

resource "google_container_node_pool" "gke_node_pool" {
  project = var.project
  cluster = google_container_cluster.gke_cluster.name
  //  node_locations = ["europe-west3-a", "europe-west3-b", "europe-west3-c"]
  node_locations = ["europe-west3-a"]
  location       = google_container_cluster.gke_cluster.location
  node_count     = 1

  node_config {
    preemptible  = true
    machine_type = var.machine_type

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
