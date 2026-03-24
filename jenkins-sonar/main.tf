# ── SonarQube ────────────────────────────────────────────────────────────────

resource "kubernetes_namespace" "sonarqube" {
  metadata {
    name = var.sonarqube_namespace
  }
}

resource "kubernetes_persistent_volume_claim" "sonarqube_pvc" {
  metadata {
    name      = "sonarqube-pvc"
    namespace = kubernetes_namespace.sonarqube.metadata[0].name
  }

  spec {
    access_modes = ["ReadWriteOnce"]

    resources {
      requests = {
        storage = var.sonarqube_storage_size
      }
    }

    storage_class_name = "standard"
  }
}

resource "helm_release" "sonarqube" {
  name       = "sonarqube"
  repository = "https://SonarSource.github.io/helm-chart-sonarqube"
  chart      = "sonarqube"
  namespace  = kubernetes_namespace.sonarqube.metadata[0].name
  version    = var.sonarqube_chart_version

  values = [
    yamlencode({
      service = {
        type     = "NodePort"
        nodePort = var.sonarqube_node_port
      }

      account = {
        adminPassword        = var.sonarqube_admin_password
        currentAdminPassword = "admin"
      }

      persistence = {
        enabled          = true
        storageClass     = "standard"
        size             = var.sonarqube_storage_size
        existingClaim    = kubernetes_persistent_volume_claim.sonarqube_pvc.metadata[0].name
      }

      resources = {
        requests = {
          cpu    = "250m"
          memory = "1Gi"
        }
        limits = {
          cpu    = "1000m"
          memory = "2Gi"
        }
      }

      postgresql = {
        enabled = true
        persistence = {
          enabled      = true
          storageClass = "standard"
          size         = var.sonarqube_db_storage_size
        }
      }
    })
  ]

  depends_on = [
    kubernetes_namespace.sonarqube,
    kubernetes_persistent_volume_claim.sonarqube_pvc,
  ]
}

# ── Jenkins ───────────────────────────────────────────────────────────────────

resource "kubernetes_namespace" "jenkins" {
  metadata {
    name = var.namespace
  }
}

resource "kubernetes_persistent_volume_claim" "jenkins_pvc" {
  metadata {
    name      = "jenkins-pvc"
    namespace = kubernetes_namespace.jenkins.metadata[0].name
  }

  spec {
    access_modes = ["ReadWriteOnce"]

    resources {
      requests = {
        storage = var.storage_size
      }
    }

    storage_class_name = "standard"
  }
}

resource "helm_release" "jenkins" {
  name       = "jenkins"
  repository = "https://charts.jenkins.io"
  chart      = "jenkins"
  namespace  = kubernetes_namespace.jenkins.metadata[0].name
  version    = var.jenkins_chart_version

  values = [
    yamlencode({
      controller = {
        admin = {
          username = var.jenkins_admin_user
          password = var.jenkins_admin_password
        }
        serviceType   = "NodePort"
        nodePort      = var.jenkins_node_port
        resources = {
          requests = {
            cpu    = "250m"
            memory = "512Mi"
          }
          limits = {
            cpu    = "1000m"
            memory = "1Gi"
          }
        }
      }
      persistence = {
        enabled       = true
        existingClaim = kubernetes_persistent_volume_claim.jenkins_pvc.metadata[0].name
        storageClass  = "standard"
        size          = var.storage_size
      }
    })
  ]

  depends_on = [
    kubernetes_namespace.jenkins,
    kubernetes_persistent_volume_claim.jenkins_pvc,
  ]
}
