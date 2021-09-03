terraform {
  backend "gcs" {
    bucket = "project94-tfstate"
    prefix = "terraform/state"
  }
}
