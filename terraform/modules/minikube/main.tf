resource "null_resource" "cluster" {

  triggers = {
    profile = var.profile
    nodes   = var.nodes
    cpus    = var.cpus
    memory  = var.memory
  }

  provisioner "local-exec" {
    command = <<EOT
minikube start \
  --profile=${var.profile} \
  --nodes=${var.nodes} \
  --cpus=${var.cpus} \
  --memory=${var.memory} \
  --driver=docker
EOT
  }
}