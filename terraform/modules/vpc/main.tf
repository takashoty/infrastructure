resource "google_compute_network" "vpc" {
  name = "kv094-vpc"
//  name                    = var.vpc_name
  auto_create_subnetworks = "false"
}

//resource "google_compute_network" "vpc" {
//  name                    = "${var.project_id}-vpc"
//  auto_create_subnetworks = "false"
//}
//
//# Subnet
//resource "google_compute_subnetwork" "subnet" {
//  name          = "${var.project_id}-subnet"
//  region        = var.region
//  network       = google_compute_network.vpc.name
//  ip_cidr_range = "10.10.0.0/24"
//}
