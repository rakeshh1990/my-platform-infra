variable "namespace" {
  type    = string
  default = "argocd"
}

variable "chart_version" {
  type    = string
  default = "9.5.21"
}

variable "hostname" {
  type    = string
  default = "argocd.local"
}

variable "ingress_class_name" {
  type    = string
  default = "nginx"
}