variable "enable" {
  description = "Enable or disable Calico"
  default     = true
  type        = bool
}

variable "chart_version" {
  description = "Helm chart version"
  default     = "0.3.1"
  type        = string
}

variable "create_namespace" {
  description = "Whether to create the namespace defined in the namespace variable. Will fail if the namespace already exists."
  default     = false
}

variable "namespace" {
  description = "Namespace to deploy Calico in."
  default     = "kube-system"
  type        = string
}

variable "wait" {
  description = "Whether to wait for the deployment of this add-on to succeed before completing."
  default     = true
}
