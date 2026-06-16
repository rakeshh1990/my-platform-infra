# Manages the minikube VM lifecycle. `terraform apply` ensures the cluster
# exists and is running; `terraform destroy` tears it down entirely.
#
# NOTE: minikube itself has its own start/stop state on disk independent of
# this resource. This resource's job is only to GUARANTEE a cluster exists
# when you run `terraform apply` (e.g. after a `minikube delete`, or on a
# brand-new machine). Day-to-day, just use `minikube start` / `minikube stop`
# directly - you don't need to run terraform for that.

resource "null_resource" "minikube_cluster" {
  triggers = {
    profile = var.minikube_profile
    cpus    = var.minikube_cpus
    memory  = var.minikube_memory
    nodes   = var.minikube_nodes
  }

  provisioner "local-exec" {
    command = <<-EOT
      set -e
      if minikube status -p ${var.minikube_profile} >/dev/null 2>&1; then
        echo "minikube profile '${var.minikube_profile}' already running."
      else
        minikube start \
          -p ${var.minikube_profile} \
          --nodes=${var.minikube_nodes} \
          --cpus=${var.minikube_cpus} \
          --memory=${var.minikube_memory} \
          --driver=docker \
          --ports=80:80,443:443
      fi
      kubectl wait --for=condition=Ready nodes --all --timeout=300s
    EOT
  }

  provisioner "local-exec" {
    when    = destroy
    command = "minikube delete -p ${self.triggers.profile} || true"
  }
}

resource "kubernetes_namespace" "ai_assistant" {
  metadata {
    name = "ai-assistant"
  }

  depends_on = [null_resource.minikube_cluster]
}