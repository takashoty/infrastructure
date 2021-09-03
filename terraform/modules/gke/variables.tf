//variable "gke_cluster_name" {
//  description = ""
//}

variable "cluster_name" {
  description = ""
  default = "kv094-cluster"
}

variable "location" {
  description = "Location"
}

variable "vpc_name" {
  description = ""
}

variable "project" {
  description = ""
}

variable "machine_type" {
  description = ""
  default     = "e2-medium"
}

variable "subnet_name" {
  description = ""
}
