#-------------------providers----------------

data "aws_region" "current" {}

data "aws_eks_cluster" "this" {
  name = module.eks_cluster.cluster_arn
}

data "aws_eks_cluster_auth" "this" {
  name = module.eks_cluster.cluster_arn
}

provider "aws" {
  region = "ap-southeast-1"
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.this.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority.0.data)
    token                  = data.aws_eks_cluster_auth.this.token
  }
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.this.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.this.token
}
