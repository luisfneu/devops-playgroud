output "jenkins_namespace" {
  description = "Namespace where Jenkins is deployed"
  value       = kubernetes_namespace.jenkins.metadata[0].name
}

output "jenkins_access_command" {
  description = "Command to access Jenkins via minikube"
  value       = "minikube service jenkins -n ${var.namespace}"
}

output "jenkins_node_port" {
  description = "NodePort assigned to Jenkins"
  value       = var.jenkins_node_port
}

output "jenkins_admin_user" {
  description = "Jenkins admin username"
  value       = var.jenkins_admin_user
}

output "jenkins_url_hint" {
  description = "How to get the Jenkins URL on minikube"
  value       = "Run: minikube service jenkins -n ${var.namespace} --url"
}
