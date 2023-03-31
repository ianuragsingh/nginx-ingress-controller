resource "kubernetes_pod_v1" "app1" {
  metadata {
    name      = "my-app1"
    namespace = var.namespace
    
    labels = {
      "app" = "app1"
    }
  }

  spec {
    container {
      image = "hashicorp/http-echo"
      name  = "my-app1"
      args  = ["-text=Hello from app 1"]
    }
  }

  depends_on = [
    module.eks_cluster,
    kubernetes_namespace.my_namespace
  ]
}

resource "kubernetes_pod_v1" "app2" {
  metadata {
    name      = "my-app2"
    namespace = var.namespace

    labels = {
      "app" = "app2"
    }
  }

  spec {
    container {
      image = "hashicorp/http-echo"
      name  = "my-app2"
      args  = ["-text=Hello from app 2"]
    }
  }

  depends_on = [
    module.eks_cluster,
    kubernetes_namespace.my_namespace
  ]
}
