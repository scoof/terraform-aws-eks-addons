terraform {
  required_version = "> 0.12.0"
}

provider "kubernetes" {
  host                   = var.eks_endpoint
  cluster_ca_certificate = var.eks_cluster_ca_certificate
  token                  = var.eks_token
  load_config_file       = false
  version                = "~> 1.9"
}

provider "aws" {
  version = "~> 2.0"
  region  = "eu-central-1"
}

module "aws_node_termination_handler" {
  source        = "./modules/aws-node-termination-handler"

  cluster_name  = var.cluster_name

  enable        = lookup(var.aws_node_termination_handler, "enable", "false")
  chart_version = lookup(var.aws_node_termination_handler, "chart_version", "0.7.5")
  namespace     = lookup(var.aws_node_termination_handler, "namespace", "kube-system")
}

# # module "cert_manager" {
# #   source       = "./modules/cert-manager"
# #   cert_manager = var.cert_manager
# }

module "cilium" {
  source        = "./modules/cilium"
  
  cluster_name  = var.cluster_name

  enable        = lookup(var.cilium, "enable", "false")

  chart_version = lookup(var.cilium, "chart_version", "1.7.4")
  namespace     = lookup(var.cilium, "namespace", "kube-system")
  cluster_id    = lookup(var.cilium, "cluster_id", 1)
}

module "cluster_autoscaler" {
  source                   = "./modules/cluster-autoscaler"
  
  cluster_name             = var.cluster_name
  tags                     = var.tags
  
  enable                   = lookup(var.cluster_autoscaler, "enable", "false")
  asg_tags                 = lookup(var.cluster_autoscaler, "asg_tags", {})
  chart_version            = lookup(var.cluster_autoscaler, "chart_version", "7.0.0")
  oidc_provider_issuer_url = lookup(var.cluster_autoscaler, "oidc_provider_issuer_url", "")
  oidc_provider_arn        = lookup(var.cluster_autoscaler, "oidc_provider_arn", "")
}

# module "external_dns" {
#   source       = "./modules/external-dns"
#   external_dns = var.external_dns
# }

module "kube_monkey" {
  source       = "./modules/kube-monkey"
  
  cluster_name = var.cluster_name
  
  enable       = lookup(var.kube_monkey, "enable", "false")
  namespace    = lookup(var.kube_monkey, "namespace", "kube-system")
  dry_run      = lookup(var.kube_monkey, "dry_run", "false")
  run_hour     = lookup(var.kube_monkey, "run_hour", 7)
  start_hour   = lookup(var.kube_monkey, "start_hour", 10)
  end_hour     = lookup(var.kube_monkey, "end_hour", 15)
  timezone     = lookup(var.kube_monkey, "timezone", "Europe/Copenhagen")
}

module "loki" {
  source                   = "./modules/loki"

  cluster_name             = var.cluster_name
  
  enable                   = lookup(var.loki, "enable", "false")
  chart_version            = lookup(var.loki, "chart_version", "0.37.3")
  namespace                = lookup(var.loki, "namespace", "kube-system")
  persistence_size         = lookup(var.loki, "persistence_size", "10Gi")
  resources_request_cpu    = lookup(var.loki, "resources_request_cpu", "100m")
  resources_request_memory = lookup(var.loki, "resources_request_memory", "256Mi")
}

module "metrics_server" {
  source        = "./modules/metrics-server"
  
  cluster_name  = var.cluster_name
  
  enable        = lookup(var.loki, "enable", "false")
  chart_version = lookup(var.loki, "chart_version", "11.3.0")
  namespace     = lookup(var.loki, "namespace", "kube-system")
}

module "prometheus" {
  source                   = "./modules/prometheus"

  enable                   = lookup(var.prometheus, "enable", "false")
  chart_version            = lookup(var.prometheus, "chart_version", "11.3.0")
  namespace                = lookup(var.prometheus, "namespace", "kube-system")
  persistence_size         = lookup(var.prometheus, "persistence_size", "10Gi")
  retention                = lookup(var.prometheus, "retention", "720h")
}