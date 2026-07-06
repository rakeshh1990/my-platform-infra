module "minikube" {
  source = "../../modules/minikube"

  profile = var.minikube_profile
  nodes   = var.minikube_nodes
  cpus    = var.minikube_cpus
  memory  = var.minikube_memory
}

module "ingress_nginx" {
  source = "../../modules/ingress-nginx"

  depends_on = [
    module.minikube
  ]
}

module "argocd" {
  source = "../../modules/argocd"

  depends_on = [
    module.ingress_nginx
  ]
}

module "external_secrets" {

  source = "../../modules/external-secrets"

}

module "bootstrap" {
  source = "../../modules/bootstrap"

  gitops_repo = var.gitops_repo_url

  depends_on = [
    module.argocd
  ]
}