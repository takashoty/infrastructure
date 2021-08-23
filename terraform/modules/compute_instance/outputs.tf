output "external_ip_address_instance" {
  value = google_compute_address.static.address
}
