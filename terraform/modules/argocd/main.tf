resource "helm_release" "this" {

  name       = "argocd"

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = var.chart_version

  namespace        = var.namespace
  create_namespace = true

  timeout = 600

  set {
    name  = "server.service.type"
    value = "NodePort"
  }

  set {
    name  = "configs.params.server\\.insecure"
    value = "true"
  }

}

resource "kubernetes_ingress_v1" "this" {

  metadata {

    name      = "argocd-server"
    namespace = var.namespace

    annotations = {
      "nginx.ingress.kubernetes.io/ssl-redirect" = "false"
    }

  }

  spec {

    ingress_class_name = var.ingress_class_name

    rule {

      host = var.hostname

      http {

        path {

          path      = "/"
          path_type = "Prefix"

          backend {

            service {

              name = "argocd-server"

              port {
                number = 80
              }

            }

          }

        }

      }

    }

  }

  depends_on = [
    helm_release.this
  ]

}