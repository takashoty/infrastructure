resource "google_compute_firewall" "firewall-rules" {
  project = var.project
  name    = "frontend-firewall-rules"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80", "5000", "5001", "5671", "5672", "5673", "15672"]
  }

  target_tags = ["app"]
}

resource "google_compute_address" "static" {
  name = "ipv4-address"
}

resource "google_compute_instance" "vm_instance" {
  count        = var.instance_count
  name         = "kv094-instance-${count.index}"
  machine_type = var.machine_type

  boot_disk {
    initialize_params {
      image = var.instance_disk_image
    }
  }

  network_interface {
    network = var.network_name
    access_config {
      nat_ip = google_compute_address.static.address
    }
  }

  metadata = {
    ssh-keys = "serve:${file(var.public_key_path)}"
  }

  tags = ["app", "frontend-firewall-rules"]
}
