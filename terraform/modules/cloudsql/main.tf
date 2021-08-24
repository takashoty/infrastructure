provider "random" {}

resource "random_id" "id" {
  byte_length = 4
  prefix      = "kv094-db-instance-"
}

resource "google_sql_database" "db" {
  instance = google_sql_database_instance.db_instance.name
  name     = "kv094-db"
}

resource "google_sql_database_instance" "db_instance" {
  name             = random_id.id.hex
  region           = var.region
  database_version = "POSTGRES_13"
  settings {
    tier      = var.db_tier
    disk_type = var.sql_disk_type
    disk_size = var.sql_disk_size
  }

  deletion_protection = "false"
}
