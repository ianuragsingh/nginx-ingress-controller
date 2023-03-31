#------------------- Variables --------------------

variable "name" {
  description = "Name of helm release"
  type        = string
  default     = "ingress-nginx"
}

variable "create_namespace" {
  description = "Create a new namespace for or not"
  type        = bool
  default     = true
}

variable "namespace" {
  description = "Name of namespace where nginx controller should be deployed"
  type        = string
  default     = "ingress-nginx"
}

variable "chart_version" {
  description = "HELM Chart Version for nginx controller"
  type        = string
  default     = "4.4.2"
}

variable "atomic" {
  description = "If set, installation process purges chart on fail"
  type        = bool
  default     = false
}

variable "ingress_class_name" {
  description = "IngressClass resource name"
  type        = string
  default     = "nginx"
}

variable "ingress_class_is_default" {
  description = "IngressClass resource default for cluster"
  type        = bool
  default     = true
}

variable "ip_address" {
  description = "External Static Address for loadbalancer (Doesn't work with AWS)"
  type        = string
  default     = null
}

variable "controller_kind" {
  description = "Controller type: DaemonSet, Deployment etc."
  type        = string
  default     = "DaemonSet"
}

variable "controller_daemonset_useHostPort" {
  description = "Also use host ports(80,443) for pods. Node Ports in services will be untouched"
  type        = bool
  default     = false
}

variable "controller_service_externalTrafficPolicy" {
  description = "Traffic policy for controller. Please refer docs."
  type        = string
  default     = "Local"
}

variable "controller_service_enableHttp" {
  description = "Controller service enable http port on NLB"
  type        = bool
  default     = true
}

variable "controller_service_enableHttps" {
  description = "Controller service enable https port on NLB"
  type        = bool
  default     = true
}

variable "controller_service_targetPorts_http" {
  description = "Controller service https targetPort"
  type        = string
  default     = "http"
}

variable "controller_service_targetPorts_https" {
  description = "Controller service https targetPort"
  type        = string
  default     = "https"
}

variable "controller_request_memory" {
  description = "Memory request for pod. Value in MB"
  type        = number
  default     = 140
}

variable "publish_service" {
  description = "Publish LoadBalancer endpoint to Service"
  type        = bool
  default     = true
}

variable "define_nodePorts" {
  description = "By default service using NodePorts. It can be generated automatically, or you can assign this ports number"
  type        = bool
  default     = true
}

variable "service_nodePort_http" {
  description = "NodePort number for http"
  type        = string
  default     = "32001"
}

variable "service_nodePort_https" {
  description = "NodePort number for https"
  type        = string
  default     = "32002"
}

variable "metrics_enabled" {
  description = "Allow exposing metrics for prometheus-operator"
  type        = bool
  default     = false
}

variable "disable_heavyweight_metrics" {
  description = "Disable some 'heavyweight' or unnecessary metrics"
  type        = bool
  default     = false
}

variable "additional_set" {
  description = "Add additional set for helm"
  default     = []
}

variable "aws_load_balancer_type" {
  description = "AWS Load balancer type"
  type        = string
  default     = "nlb"
}

variable "load_balancer_source_ranges" {
  description = "CIDRs range that are allowed to access the NLB."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "aws_load_balancer_ssl_ports" {
  description = "AWS load balancer ssl port"
  type        = string
  default     = "https"
}

variable "aws_load_balancer_ssl_cert" {
  description = "ACM certificate arn of load balancer"
  type        = string
  default     = ""
}

variable "wait" {
  description = "Will wait until all resources are in a ready state"
  type        = bool
  default     = true
}

variable "timeout" {
  description = "Time in seconds to wait for any individual kubernetes operation"
  type        = number
  default     = 300
}
