variable "kube_context" {
  description = "Kubernetes context to use (minikube)"
  type        = string
  default     = "minikube"
}

variable "namespace" {
  description = "Kubernetes namespace for Jenkins"
  type        = string
  default     = "jenkins"
}

variable "jenkins_chart_version" {
  description = "Jenkins Helm chart version"
  type        = string
  default     = "5.9.8"
}

variable "jenkins_admin_user" {
  description = "Jenkins admin username"
  type        = string
  default     = "admin"
}

variable "jenkins_admin_password" {
  description = "Jenkins admin password"
  type        = string
  sensitive   = true
  default     = "admin123"
}

variable "jenkins_node_port" {
  description = "NodePort for Jenkins service (30000-32767)"
  type        = number
  default     = 32080
}

variable "storage_size" {
  description = "Persistent volume size for Jenkins"
  type        = string
  default     = "5Gi"
}

# SonarQube variables
variable "sonarqube_namespace" {
  description = "Kubernetes namespace for SonarQube"
  type        = string
  default     = "sonarqube"
}

variable "sonarqube_chart_version" {
  description = "SonarQube Helm chart version"
  type        = string
  default     = "10.3.0"
}

variable "sonarqube_admin_password" {
  description = "SonarQube admin password"
  type        = string
  sensitive   = true
  default     = "admin123"
}

variable "sonarqube_node_port" {
  description = "NodePort for SonarQube service (30000-32767)"
  type        = number
  default     = 32090
}

variable "sonarqube_storage_size" {
  description = "Persistent volume size for SonarQube data"
  type        = string
  default     = "5Gi"
}

variable "sonarqube_db_storage_size" {
  description = "Persistent volume size for SonarQube PostgreSQL"
  type        = string
  default     = "5Gi"
}
