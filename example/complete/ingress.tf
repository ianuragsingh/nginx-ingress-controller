resource "kubernetes_ingress_v1" "ingress" {
  wait_for_load_balancer = true

  depends_on = [
    module.eks_cluster,
    kubernetes_namespace.my_namespace
  ]

  metadata {
    name      = "fanout-ingress-resource"
    namespace = var.namespace
  }

  spec {
    ingress_class_name = "nginx"

    rule {
      http {
        path {
          backend {
            service {
              name = "app1-service"
              port {
                number = 5678
              }
            }
          }

          path = "/app1"
        }

        path {
          backend {
            service {
              name = "app2-service"
              port {
                number = 5678
              }
            }
          }

          path = "/app2"
        }
      }
    }

  }
}
