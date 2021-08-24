provider "google" {
  credentials = var.service_account_key_file
  project     = var.project
  region      = var.region
  zone        = var.zone
}

module "vpc" {
  source     = "../modules/vpc"
  project_id = var.project_id
}

module "subnet" {
  source   = "../modules/subnet"
  vpc_name = module.vpc.vpc_name
  region   = var.region
}

module "firewall" {
  source   = "../modules/firewall"
  vpc_name = module.vpc.vpc_name
}

module "cloudsql" {
  source        = "../modules/cloudsql"
  region        = var.region
  sql_disk_size = var.sql_disk_size
  sql_disk_type = var.sql_disk_type
}

module "gke" {
  source      = "../modules/gke"
  vpc_name    = module.vpc.vpc_name
  subnet_name = module.subnet.subnet_name
  project     = var.project
  location    = var.location
}

module "compute_instance" {
  source                   = "../modules/compute_instance"
  vpc_name                 = module.vpc.vpc_name
  region                   = var.region
  zone                     = var.zone
  instance_disk_image      = var.instance_disk_image
  instance_name            = var.instance_name
  instance_count           = var.instance_count
  machine_type             = var.machine_type
  project                  = var.project
  project_id               = var.project_id
  public_key_path          = var.public_key_path
  service_account_key_file = var.service_account_key_file
}
