variable "chart_version" {
  default     = "0.37.3"
  description = "Loki version to install"
  type        = string
}

variable "namespace" {
  description = "Namespace to install loki in"
  default     = "kube-system"
  type        = string
}

variable "enable" {
  default     = true
  description = "Enable or Disable loki."
  type        = bool
}

variable "cluster_name" {
  description = "Name of the EKS cluster to deply Loki into."
  type        = string
}

variable "create_namespace" {
  description = "Whether to create the namespace defined in the namespace variable. Will fail if the namespace already exists."
  default     = false
}

variable "oidc_provider_issuer_url" {
  description = "Issuer used in the OIDC provider associated with the EKS cluster to support IRSA."
  type        = string
}

variable "values_overrides" {
  description = "Helm Chart values which will override defaults."
  type        = any
  default     = {}
}

variable "prometheus_uri" {
  description = "URI of Prometheus service complete with protocol and port."
  default     = "http://prometheus-server.kube-system.svc.cluster.local:9090"
}

variable "retention_days" {
  description = "Number of days Loki will store logs."
  default     = 30
}

variable "tags" {
  description = "Tags to apply to taggable resources provisioned by this module."
  type        = map(string)
  default     = {}
}

variable "wait" {
  description = "Whether to wait for the deployment of this add-on to succeed before completing."
  default     = false
}
