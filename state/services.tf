// Enable required services on the project
resource "google_project_service" "service" {
  count   = length(var.project_services)
  project = var.gcp_project
  service = element(var.project_services, count.index)

  disable_on_destroy = false
}
