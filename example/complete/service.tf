resource "kubernetes_service_v1" "app1_service" {
  metadata {
    name      = "app1-service"
    namespace = var.namespace
  }
  spec {
    selector = {
      app = kubernetes_pod_v1.app1.metadata.0.labels.app
    }
    port {
      port = 5678
    }
  }

  depends_on = [
    module.eks_cluster,
    kubernetes_namespace.my_namespace
  ]
}

resource "kubernetes_service_v1" "app2_service" {
  metadata {
    name      = "app2-service"
    namespace = var.namespace
  }
  spec {
    selector = {
      app = kubernetes_pod_v1.app2.metadata.0.labels.app
    }
    port {
      port = 5678
    }
  }

  depends_on = [
    module.eks_cluster,
    kubernetes_namespace.my_namespace
  ]
}
