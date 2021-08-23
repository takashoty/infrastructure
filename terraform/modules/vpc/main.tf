resource "google_compute_network" "vpc" {
//  name = "kv094-name"
  name                    = var.network_name
  auto_create_subnetworks = "true"
}
