provider "google" {
  credentials = var.service_account_key_file
  project     = var.project_id
  region      = var.region
  zone        = var.zone
}

data "google_client_config" "default" {}

provider "kubernetes" {
  cluster_ca_certificate = module.gke_auth.cluster_ca_certificate
  host                   = module.gke_auth.host
  token                  = module.gke_auth.token
}

provider "helm" {
  kubernetes {
    host = "https://${module.gke.endpoint}"
    cluster_ca_certificate = module.gke_auth.cluster_ca_certificate
    token = data.google_client_config.default.access_token
  }
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

module "gke_auth" {
  source = "terraform-google-modules/kubernetes-engine/google//modules/auth"
  depends_on = [module.gke]
  cluster_name = module.gke.cluster_name
  location = module.gke.cluster_location
  project_id = var.project
}

resource "local_file" "kubeconfig" {
  depends_on = [module.gke_auth]
  content = module.gke_auth.kubeconfig_raw
  filename = "kubeconfig"
}

//resource "time_sleep" "wait_30_seconds" {
//  depends_on = [local_file.kubeconfig]
//
//  create_duration = "30s"
//}

module "jenkins" {
//  depends_on = [time_sleep.wait_30_seconds]
  source = "../modules/helm_charts_jenkins"
  location = module.gke.cluster_location
}

//module "compute_instance" {
//  source                   = "../modules/compute_instance"
//  vpc_name                 = module.vpc.vpc_name
//  region                   = var.region
//  zone                     = var.zone
//  instance_disk_image      = var.instance_disk_image
//  instance_name            = var.instance_name
//  instance_count           = var.instance_count
//  machine_type             = var.machine_type
//  project                  = var.project
//  project_id               = var.project_id
//  public_key_path          = var.public_key_path
//  service_account_key_file = var.service_account_key_file
//}
