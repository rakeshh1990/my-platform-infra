resource "helm_release" "this" {

  name       = "ingress-nginx"

  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = var.chart_version

  namespace        = var.namespace
  create_namespace = true

  values = [
    yamlencode({
      controller = {
        service = {
          type = "NodePort"
        }
      }
    })
  ]
}