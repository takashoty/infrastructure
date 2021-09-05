provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}

terraform {
  backend "gcs" {
    bucket = "terstate"
    prefix = "ter-folder"
  }
}

module "vpc" {
  source = "./modules/vpc"
}

module "gke" {
  source = "./modules/gke"
}

module "cloudsql" {
  source = "./modules/cloudsql"
}
