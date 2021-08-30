/**
 * Copyright 2018 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

variable "project_id" {
  description = "The project ID to host the cluster in"
  default = "natural-aria-324506"
}

variable "cluster_name_suffix" {
  description = "A suffix to append to the default cluster name"
  default     = "kv-94kub5"
}

variable "region" {
  description = "The region to host the cluster in"
  default = "europe-west2"
}

variable "network" {
  description = "The VPC network to host the cluster in"
  default = "kv094network"
}

variable "subnetwork" {
  description = "The subnetwork to host the cluster in"
  default = "kv094subnet"
}

variable "service_account_key_file" {
  description = "Path to .json key"
  default = "/Users/takashoty/Documents/Workspace/natural-aria-324506-c1efebc68931.json"
}

variable "ip_range_pods" {
  description = "The secondary ip range to use for pods"
  default = "10.0.0.0/14"
}

variable "ip_range_services" {
  description = "The secondary ip range to use for services"
  default = "10.4.0.0/19"
}

variable "compute_engine_service_account" {
  description = "Service account to associate to the nodes in the cluster"
  default = "59771285470-compute@developer.gserviceaccount.com"
}

