resource "google_storage_bucket" "gcs_store" {
  project = var.gcp_project
  name = var.gcs_bucket
  location = var.region
}


