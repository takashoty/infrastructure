output "vpc_name" {
  value = google_compute_network.vpc.name
}
output "subnet" {
  value = google_compute_subnetwork.subnet.name
}