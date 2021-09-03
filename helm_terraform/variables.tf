variable "jenkins" {
  type = string
  default = "project94-jenk"
}

variable "gcp_project" {
  type = string
}

variable "cluster_name" {
  description = "The name to give the new Kubernetes cluster."
  type        = string
}