variable "cluster_name" {
  description = "Name of the EKS cluster to deply cluster-autoscaler into."
  type        = string
}

variable "chart_version" {
  description = "Version of the cluster-autoscaler chart to deploy. Must match the version of EKS. See https://github.com/helm/charts/tree/master/stable/cluster-autoscaler."
  default     = "7.0.0"
}

variable "enable" {
  description = "Whether to actually deploy the cluster-autoscaler."
  default     = true
}

variable "namespace" {
  description = "Namespace to install cluster-autoscaler in"
  default     = "kube-system"
  type        = string
}

variable "asg_tags" {
  description = "The tags to look for when detecting Auto-Scaling Groups. If left empty, the defaults will be used. Defaults are documented here: https://github.com/kubernetes/autoscaler/tree/master/cluster-autoscaler/cloudprovider/aws#auto-discovery-setup."
  type        = map(string)
  default     = {}
}

variable "oidc_provider_issuer_url" {
  description = "Issuer used in the OIDC provider associated with the EKS cluster to support IRSA."
  type        = string
}

variable "oidc_provider_arn" {
  description = "ARN of the OIDC provider associated with the EKS cluster to support IRSA."
  type        = string
}

variable "tags" {
  description = "Tags to apply to taggable resources provisioned by this module."
  type        = map(string)
  default     = {}
}

variable "priority_class" {
  type        = string
  default     = "system-cluster-critical"
  description = "Change cluster autoscaler priority class"
}

variable "extra_args" {
  description = "Extra arguments to pass to cluster-autoscaler."
  type        = map(string)
  default     = {}
}

variable "wait" {
  description = "Whether to wait for the deployment of this add-on to succeed before completing."
  default     = true
}
