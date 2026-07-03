variable "gitops_repo" {
  type = string
}

variable "gitops_path" {
  type    = string
  default = "apps"
}

variable "target_revision" {
  type    = string
  default = "main"
}

variable "namespace" {
  type    = string
  default = "argocd"
}