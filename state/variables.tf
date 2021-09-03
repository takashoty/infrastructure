///////////////////////////////////
// variables definitions and types
///////////////////////////////////
variable "env" {
  type = string
}

variable "gcp_prefix" {
  type = string
  default = "project94"
}

variable "gcp_project" {
  type = string
}
variable "gcp_alias" {
  type = string
}
variable "gcs_bucket" {
  type = string
}

variable "region" {
  type = string
  default = "europe-west6"
}

variable "zone" {
  type = string
  default = "europe-west6-a"
}

variable "zones" {
  type = list(string)
  default = ["europe-west6-a"]
}

variable "vpc_name" {
  type = string
}

variable "gke_iam_roles" {
  type = map(string)

  default = {
    role1 = "roles/container.admin"
    role2 = "roles/compute.admin"
    role3 = "roles/iam.serviceAccountUser"
    role4 = "roles/resourcemanager.projectIamAdmin"
  }
  description = "GKE Service account roles to be assigned."
}

variable "subnet_cidr" {
  type = string
}

variable "subnet_pod_cidr" {
  type = string
}

variable "subnet_service_cidr" {
  type = string
}

variable "gke_master_cidr" {
  type = string
}

variable "gke_pool01_machines" {
  type = string
}

variable "gke_pool01_preemptible" {
  type = string
}

variable "gke_pool02_machines" {
  type = string
}

variable "gke_pool02_preemptible" {
  type = string
}


variable "subnet_name" {
  type = string
}

variable "project_services" {
  type = list(string)

  default = [
    "cloudresourcemanager.googleapis.com",
    "servicenetworking.googleapis.com",
    "container.googleapis.com",
    "compute.googleapis.com",
    "iam.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "sqladmin.googleapis.com",
    "securetoken.googleapis.com",
    "cloudkms.googleapis.com",
    "dns.googleapis.com",
  ]
  description = "The GCP APIs that should be enabled in this project."
}

variable "cluster_name" {
  description = "The name to give the new Kubernetes cluster."
  type        = string
}

variable "k8s_namespace" {
  description = "The namespace to use for the deployment and workload identity binding"
  type        = string
  default     = "default"
}

variable "k8s_sa_name" {
  description = "The k8s service account name to use for the deployment and workload identity binding"
  type        = string
  default     = "mysql"
}

variable "k8s_version" {
  description = "Current version of Kubernetes"
  type        = string
}

variable "pgsql_inst01_version" {
  type = string
}

variable "pgsql_inst01_availability" {
  type = string
}

variable "pgsql_inst01_tier" {
  type = string
}

variable "pgsql_inst01_disk_size" {
  type = string
}

variable "pgsql_inst01_disk_type" {
  type = string
}

variable "pgsql_inst01_disk_autoresize" {
  type = bool
}


variable "jenkins_home_pd_size" {
  type = string
}


