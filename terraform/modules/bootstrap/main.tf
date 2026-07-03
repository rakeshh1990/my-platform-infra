resource "kubernetes_manifest" "this" {

  manifest = {

    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"

    metadata = {
      name      = "root"
      namespace = var.namespace
    }

    spec = {

      project = "default"

      source = {

        repoURL        = var.gitops_repo
        targetRevision = var.target_revision
        path           = var.gitops_path

        directory = {
          recurse = true
        }

      }

      destination = {

        server    = "https://kubernetes.default.svc"
        namespace = var.namespace

      }

      syncPolicy = {

        automated = {
          prune    = true
          selfHeal = true
        }

        syncOptions = [
          "CreateNamespace=true"
        ]

      }

    }

  }

}