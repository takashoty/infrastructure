resource "google_compute_firewall" "firewall-rules" {
  project = var.project
  name    = "frontend-firewall-rules"
  network = var.vpc_name

  allow {
    protocol = "tcp"
    ports    = ["80", "443", "8080", "5000", "5001", "5671", "5672", "5673", "15672"]
  }

  target_tags = ["app"]
}
