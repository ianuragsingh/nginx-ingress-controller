#-------------- Nginx ingress controller ---------------

data "kubernetes_service" "ingress_nginx" {
  metadata {
    name      = "nginx-ingress-controller"
    namespace = helm_release.nginx_ingress_controller.namespace
  }

  depends_on = [
    helm_release.nginx_ingress_controller
  ]
}

resource "helm_release" "nginx_ingress_controller" {
  name             = var.name
  chart            = local.helm_chart
  namespace        = var.namespace
  repository       = local.helm_repository
  version          = var.chart_version
  atomic           = var.atomic
  create_namespace = var.create_namespace
  wait             = var.wait
  timeout          = var.timeout

  values = [var.disable_heavyweight_metrics ? file("${path.module}/templates/metrics-disable.yaml") : ""]

  set {
    name  = "controller.kind"
    value = var.controller_kind
  }
  set {
    name  = "controller.ingressClassResource.name"
    value = var.ingress_class_name
  }
  set {
    name  = "controller.ingressClassResource.default"
    value = var.ingress_class_is_default
  }
  set {
    name  = "controller.daemonset.useHostPort"
    value = var.controller_daemonset_useHostPort
  }
  set {
    name  = "controller.service.externalTrafficPolicy"
    value = var.controller_service_externalTrafficPolicy
  }
  set {
    name  = "controller.publishService.enabled"
    value = var.publish_service
  }
  set {
    name  = "controller.resources.requests.memory"
    type  = "string"
    value = "${var.controller_request_memory}Mi"
  }
  set {
    name  = "controller.service.enableHttp"
    value = var.controller_service_enableHttp
  }
  set {
    name  = "controller.service.enableHttps"
    value = var.controller_service_enableHttps
  }
  set {
    name  = "controller.service.targetPorts.http"
    type  = "string"
    value = var.controller_service_targetPorts_http
  }
  set {
    name  = "controller.service.targetPorts.https"
    type  = "string"
    value = var.controller_service_targetPorts_https
  }
 
  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-type"
    value = var.aws_load_balancer_type
  }
  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-cross-zone-load-balancing-enabled"
    value = "true"
    type  = "string"
  }
  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/load-balancer-source-ranges"
    value = local.alb_whitelist_source_ranges
    type  = "string"
  }
  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-ssl-ports"
    value = var.aws_load_balancer_ssl_ports
    type  = "string"
  }
  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-ssl-cert"
    value = var.aws_load_balancer_ssl_cert
    type  = "string"
  }

  dynamic "set" {
    for_each = local.controller_service_nodePorts
    content {
      name  = set.value.name
      value = set.value.value
    }
  }

  dynamic "set" {
    for_each = local.loadBalancerIP
    content {
      name  = set.value.name
      value = set.value.value
    }
  }

  dynamic "set" {
    for_each = local.metrics_enabled
    content {
      name  = set.value.name
      value = set.value.value
    }
  }

  dynamic "set" {
    for_each = var.additional_set
    content {
      name  = set.value.name
      value = set.value.value
      type  = lookup(set.value, "type", null)
    }
  }
}

