output "ipv4-address" {
  value = google_sql_database_instance.instance.ip_address
  description = "DB instance IP"
}