provider "google" {
#  credentials = file(".creds/ss-frontend-320708-1ea77fd7289f.json")
  credentials = var.service_account_key_file
  project = var.project
  region = var.region
  zone = var.zone
}

resource "google_compute_address" "static" {
  name = "ipv4-address"
}

resource "google_compute_instance" "vm_instance" {
  name = "flask-front"
  machine_type = var.machine_type

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-8"
    }
  }

  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.static.address
    }
  }

  metadata = {
    ssh-keys = "serve:${file(var.public_key_path)}"
  }
}
