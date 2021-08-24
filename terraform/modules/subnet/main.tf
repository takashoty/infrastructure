resource "google_compute_subnetwork" "kv094_subnet" {
  name = "kv094-subnet"
  ip_cidr_range = "10.10.0.0/24"
  network = var.vpc_name
  region = var.region
}
