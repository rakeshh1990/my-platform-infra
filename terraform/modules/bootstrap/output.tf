output "application_name" {
  value = kubernetes_manifest.this.object.metadata.name
}