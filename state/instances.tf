////////////////////
// Bastion Host ///
////////////////////
locals {
  hostname = format("%s-bastion", var.cluster_name)
}

// Dedicated service account for the Bastion instance
resource "google_service_account" "bastion" {
  project = var.gcp_project
  account_id   = format("%s-bastion-sa", var.cluster_name)
  display_name = "GKE Bastion SA"
}

// The user-data script on Bastion instance provisioning
data "template_file" "startup_script" {
  template = <<-EOF
  curl http://repo.openfusion.net/centos7-x86_64/tinyproxy-1.8.3-2.of.el7.x86_64.rpm --output tp.rpm
  yum install tp.rpm -y
  rm -rf tp.rpm
  sudo service tinyproxy start
  sudo yum install kubectl
  EOF

}

// The Bastion Host Instance
resource "google_compute_instance" "bastion" {
  name = local.hostname
  machine_type = "g1-small"
  zone = var.zone
  project = var.gcp_project
  tags = ["bastion"]

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-8-v20210817"
    }
  }

  // Ensure that when the bastion host is booted, it will have tinyproxy
  metadata_startup_script = data.template_file.startup_script.rendered

  // Define a network interface in the correct subnet.
  network_interface {
    subnetwork = google_compute_subnetwork.project_subnet.self_link

    // Add an ephemeral external IP.
    access_config {
      // Ephemeral IP
    }
  }

  // Allow the instance to be stopped by terraform when updating configuration
  allow_stopping_for_update = true

  service_account {
    email = google_service_account.bastion.email
    scopes = ["cloud-platform"]
  }

//  provisioner "local-exec" {
//    command = <<EOF
//        READY=""
//        for i in $(seq 1 10); do
//          if gcloud compute ssh ${local.hostname} --project ${var.gcp_project} --zone ${var.region}-a ///// --command uptime; then
//            READY="yes"
//            break;
//          fi
//          echo "Waiting for ${local.hostname} to initialize..."
//          sleep 10;
//        done
//        if [[ -z $READY ]]; then
//          echo "${local.hostname} failed to start in time."
//          echo "Please verify that the instance starts and then re-run `terraform apply`"
//          exit 1
//        fi
//EOF
//  }
}
