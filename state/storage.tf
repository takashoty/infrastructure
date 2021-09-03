/////////////////////////////
// Persistent Block Storage
/////////////////////////////


resource "google_compute_disk" "jenkins_home_persistent_disk" {
  project = var.gcp_project
  name  = format("jenkins-home-pd-%s", var.env)
  type  = "pd-standard"
  zone  = var.zone
  labels = {
    environment = var.env
  }
  size = var.jenkins_home_pd_size
  physical_block_size_bytes = 4096

  lifecycle {
//    prevent_destroy = true
    ignore_changes = [
      labels,
    ]
  }
}
