provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "helm_release" "nginx_ingress" {
  name       = "ingress-nginx"

  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"

  set {
    name  = "service.type"
    value = "LoadBalancer"
  }
}

resource "helm_release" "jenkins" {
  name       = var.jenkins

  repository = "https://charts.jenkins.io"
  chart      = "jenkins"
  # timeout    = 600
  set {
    name  = "service.type"
    value = "ClusterIP"
    
  }
  set {
    name  = "ingress.enabled"
    value = "true"
    
  }
    set {
    name  = "ingress.annotations"
    value = "kubernetes.io/ingress.class: nginx"
    
  }
  set {
    name  = "ingress.hostName"
    value = "project94.irc.if.ua"
    
  }
}