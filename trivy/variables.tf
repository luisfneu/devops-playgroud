variable "kubeconfig_path" {
  type        = string
  default     = "~/.kube/config"
}

variable "kube_context" {
  type        = string
  default     = "minikube"
}

variable "namespace" {
  type        = string
  default     = "trivy-system"
}

variable "trivy_operator_version" {
  type        = string
  default     = "0.22.0"
}

variable "scan_job_timeout" {
  type        = string
  default     = "5m"
}

variable "generate_sbom" {
  type        = bool
  default     = false
}
