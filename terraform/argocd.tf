resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true
  wait             = true
  timeout          = 600

  set {
    name  = "server.insecure"
    value = "true"
  }

  set {
    name  = "server.service.type"
    value = "NodePort"
  }

  depends_on = [null_resource.minikube_cluster]
}