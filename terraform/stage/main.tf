provider "google" {
  credentials = var.service_account_key_file
  project     = var.project
  region      = var.region
  zone        = var.zone
}

module "vpc" {
  source       = "../modules/vpc"
  project_id   = var.project_id
  network_name = var.network_name
}

module "compute_instance" {
  source                   = "../modules/compute_instance"
  region                   = var.region
  zone                     = var.zone
  instance_disk_image      = var.instance_disk_image
  instance_name            = var.instance_name
  instance_count           = var.instance_count
  machine_type             = var.machine_type
  network_name             = var.network_name
  project                  = var.project
  project_id               = var.project_id
  public_key_path          = var.public_key_path
  service_account_key_file = var.service_account_key_file
  depends_on = [module.vpc]
}
