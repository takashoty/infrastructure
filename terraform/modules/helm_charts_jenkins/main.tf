# cheat - if pre-configured k8s with gcloud
//provider "helm" {
//  kubernetes {
//    config_path = "~/.kube/config"
//  }
//}

//provider "helm" {
//  kubernetes {
//    config_path = "/home/head/PycharmProjects/kv-devops-094/infrastructure/terraform/stage/kubeconfig"
//  }
//}

resource "helm_release" "jenkins" {
  chart = "jenkins"
  name = "jenkins"
  repository = "https://charts.jenkins.io"
//  namespace = "default"
//  version = "3.5.14"
  timeout = 2400
}
