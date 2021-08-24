variable "region" {
  description = ""
}

variable "db_tier" {
  description = ""
  default     = "db-f1-micro"
}

variable "sql_disk_type" {
  description = ""
  default     = "PD_SSD"
}

variable "sql_disk_size" {
  description = ""
  default     = "10"
}