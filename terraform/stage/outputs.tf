//output "external_ip_address_instance" {
//  value = module.compute_instance.external_ip_address_instance
//}
//
output "endpoint" {
  value       = module.gke.endpoint
  description = "Endpoint for accessing the master node"
}
