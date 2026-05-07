output "namespace" {
  value       = kubernetes_namespace.trivy_system.metadata[0].name
}
output "helm_release_status" {
  value       = helm_release.trivy_operator.status
}
output "helm_release_version" {
  value       = helm_release.trivy_operator.version
}
output "verify_command" {
  value       = "kubectl get pods -n ${kubernetes_namespace.trivy_system.metadata[0].name}"
}
output "scan_report_command" {
  value       = "kubectl get vulnerabilityreports -A"
}
