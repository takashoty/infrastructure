output "endpoint" {
  value       = google_container_cluster.gke_cluster.endpoint
  description = "Endpoint for accessing the master node"
}

output "cluster_name" {
  value = google_container_cluster.gke_cluster.name
}

output "cluster_location" {
  value = google_container_cluster.gke_cluster.location
}
