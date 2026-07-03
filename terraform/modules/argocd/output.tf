output "namespace" {
  value = helm_release.this.namespace
}

output "hostname" {
  value = var.hostname
}