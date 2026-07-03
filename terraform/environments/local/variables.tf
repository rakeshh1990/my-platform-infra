variable "kubeconfig_path" {
  description = "Path to kubeconfig file"
  type        = string
  default     = "~/.kube/config"
}

variable "kube_context" {
  description = "Kubeconfig context to use"
  type        = string
  default     = "minikube"
}

variable "minikube_profile" {
  description = "Minikube profile name"
  type        = string
  default     = "minikube"
}

variable "minikube_cpus" {
  type    = number
  default = 4
}

variable "minikube_memory" {
  description = "Memory in MB"
  type        = number
  default     = 8192
}

variable "minikube_nodes" {
  description = "Number of nodes in the minikube cluster"
  type        = number
  default     = 2
}

variable "gitops_repo_url" {
  description = "URL of the GitOps repo containing apps/ and helm/"
  type        = string
  default     = "https://github.com/rakeshh1990/my-gitops.git"
}

variable "gitops_target_revision" {
  type    = string
  default = "main"
}