variable region {
  description = "Region"
}

variable zone {
  description = "Zone"
}

variable machine_type {
  description = "Machine type for instance"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable project {
  description = "Project name"
}

variable service_account_key_file {
  description = "Path to .json key"
}

//variable GITHUB_USER {
//  description = "GitHub user"
//}
//
//variable GITHUB_TOKEN {
//  description = "GitHub token"
//}

variable "project_id" {
  description = "The ID of the project where the routes will be created"
}
//
//variable "vpc_name" {
//  description = "The name of the VPC where routes will be created"
//}

variable "instance_name" {
  description = "The name of the instance"
}

variable "instance_disk_image" {
  description = "The image for instance"
}

variable "instance_count" {
  description = ""
}

variable "versioning" {
  description = "While set to true, versioning is fully enabled for this bucket."
  type        = bool
  default     = true
}
//
//variable "gke_cluster_name" {
//  description = ""
//}

variable "location" {
  description = "Location"
}
