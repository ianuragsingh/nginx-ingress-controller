#------- EKS Cluster ---------

module "eks_cluster" {
  source = "git::https://github.com/ianuragsingh/simple-eks-cluster.git?ref=v0.0.9"

  cluster_name = var.cluster_name
  subnet_ids   = ["subnet-x", "subnet-y"] #Replace with your subnet ids or pass vpc name to create vpc

  desired_size   = 1
  max_size       = 2
  min_size       = 1
  instance_types = ["t3.medium"]
}

#------- Creating separate Namespace for Services and Pods ------------

resource "kubernetes_namespace" "my_namespace" {
  metadata {
    name = var.namespace
  }

  depends_on = [
    module.eks_cluster
  ]
}
