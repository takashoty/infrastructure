output "endpoint" {
  value       = google_container_cluster.gke_cluster.endpoint
  description = "Endpoint for accessing the master node"
}
