provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "helm_release" "jenkins" {
  chart = "jenkins"
  name = "jenkins"
  repository = "https://charts.helm.sh/stable"
//  namespace = "default"
//  version = "2.5.4"
  timeout = 2400
}
