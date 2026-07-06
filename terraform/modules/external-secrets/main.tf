resource "helm_release" "this" {

  name             = "external-secrets"
  repository       = "https://charts.external-secrets.io"
  chart            = "external-secrets"
  version          = "0.18.2"

  namespace        = "external-secrets"
  create_namespace = true

  timeout = 600

}