resource "google_container_registry" "registry" {
  project  = var.gcp_project
  location = "EU"
}

resource "google_storage_bucket_iam_member" "gke_gcr_bucket_viewer" {
  bucket = google_container_registry.registry.id
  role = "roles/storage.objectViewer"
  member = format("serviceAccount:%s", google_service_account.gke_sa.email)
}

// Jenkins GCR Write
resource "google_service_account" "jenkins_gcr_writer" {
  project = var.gcp_project
  account_id = "${var.gcp_alias}-jenkins-gcr-writer"
  display_name = "${var.gcp_alias}-jenkins-gcr-writer"
}

resource "google_storage_bucket_iam_member" "jenkins_gcr_writer" {
  bucket = google_container_registry.registry.id
  role = "roles/storage.admin"
  member = format("serviceAccount:%s", google_service_account.jenkins_gcr_writer.email)
}
