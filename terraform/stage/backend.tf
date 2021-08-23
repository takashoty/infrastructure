terraform {
  backend "gcs" {
    bucket = "kv-094-bucket"
    prefix = "stage"
  }
}
