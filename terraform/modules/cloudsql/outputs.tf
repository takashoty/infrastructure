output "db_instance_sql_ipv4" {
  value       = google_sql_database_instance.db_instance.ip_address
  description = "The IPv4 address assigned for DB instance"
}
