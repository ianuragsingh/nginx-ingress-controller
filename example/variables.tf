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
  default     = null
}