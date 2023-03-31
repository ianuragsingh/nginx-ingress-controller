#-------------- variables ----------------

variable "cluster_name" {
  description = "Name of the EKS cluster where the ingress nginx will be deployed"
  type        = string
  default     = "simple-eks-cluster"
}

variable "namespace" {
  description = "EKS cluster namespace where the ingress nginx will be deployed"
  type        = string
  default     = "my-namespace"
}

#-------------- Nginx Ingress Controller ----------------

variable "nginx_ingress_chart_name" {
  description = "Nginx ingress controller chart name"
  type        = string
  default     = "ingress-nginx"
}

variable "nginx_ingress_chart_version" {
  description = "Nginx ingress controller chart version"
  type        = string
  default     = "4.3.0"
}

variable "alb_ssl_certificate_arn" {
  description = "ACM certificate arn of ingress controller"
  type        = string
  default     = ""
}