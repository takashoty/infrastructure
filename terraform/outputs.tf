output "external_ip_address_app" {
  value = google_compute_address.static.address
}
