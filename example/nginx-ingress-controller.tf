#---------- nginx ingress controller --------------

module "nginx_ingress_controller" {
  source = "../"

  name          = var.nginx_ingress_chart_name
  chart_version = var.nginx_ingress_chart_version

  controller_service_enableHttp        = false
  controller_service_targetPorts_https = "http"

  aws_load_balancer_type      = "nlb"
  aws_load_balancer_ssl_cert  = var.alb_ssl_certificate_arn
}