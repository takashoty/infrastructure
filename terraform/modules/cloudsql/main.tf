resource "google_sql_database" "database" {
  name     = "my-database"
  instance = google_sql_database_instance.instance.name
}

resource "google_sql_database_instance" "instance" {
  name   = "postgres-13"
  region = var.region
  database_version = "POSTGRES-13"
  settings {
    tier = "db-f1-micro"
  }

  deletion_protection  = "false"
}


