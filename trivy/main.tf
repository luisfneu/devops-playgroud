resource "kubernetes_namespace" "trivy_system" {
  metadata {
    name = var.namespace
    labels = {
      "app.kubernetes.io/managed-by" = "terraform"
    }
  }
}

resource "helm_release" "trivy_operator" {
  name       = "trivy-operator"
  repository = "https://aquasecurity.github.io/helm-charts/"
  chart      = "trivy-operator"
  version    = var.trivy_operator_version
  namespace  = kubernetes_namespace.trivy_system.metadata[0].name

  set {
    name  = "trivy.ignoreUnfixed"
    value = "true"
  }

  set {
    name  = "operator.scanJobTimeout"
    value = var.scan_job_timeout
  }

  set {
    name  = "trivy.mode"
    value = "Standalone"
  }

  set {
    name  = "operator.generateSbomEnabled"
    value = tostring(var.generate_sbom)
  }

  set {
    name  = "trivy.resources.requests.cpu"
    value = "100m"
  }

  set {
    name  = "trivy.resources.requests.memory"
    value = "128Mi"
  }

  set {
    name  = "trivy.resources.limits.cpu"
    value = "500m"
  }

  set {
    name  = "trivy.resources.limits.memory"
    value = "512Mi"
  }

  depends_on = [kubernetes_namespace.trivy_system]
}
