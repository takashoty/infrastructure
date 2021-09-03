# //Firewall rules
# // Allow access to the Bastion Host via SSH
# resource "google_compute_firewall" "bastion_ssh" {
#   name          = format("%s-bastion-ssh", var.cluster_name)
#   network       = google_compute_network.project_network.name
#   direction     = "INGRESS"
#   project       = var.gcp_project
#   source_ranges = ["0.0.0.0/0"]

#   allow {
#     protocol = "tcp"
#     ports    = ["22"]
#   }

#   target_tags = ["bastion"]
# }