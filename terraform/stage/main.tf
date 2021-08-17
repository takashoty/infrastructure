provider "google" {
  credentials = var.service_account_key_file
  project     = var.project
  region      = var.region
  zone        = var.zone
}

module "compute_instance" {
  source = "../modules/gke"
}
