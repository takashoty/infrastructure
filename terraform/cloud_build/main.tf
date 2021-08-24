resource "google_cloudbuild_trigger" "start_tf_trigger" {
  project = var.project
//  trigger_template {
//    branch_name = "develop-smiichuk"
//    repo_name = "infrastructure"
//  }
  github {
    owner = "devops094"
    name = "infrastructure"
    push {
      branch = "develop-smiichuk"
    }
  }

  filename = "cloudbuild.yaml"
}
