terraform {

  required_version = "0.14.10"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.72.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.0.2"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "1.3.2"
    }
  }

}

provider "aws" {
  region                  = "eu-west-1"
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "default"
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}


provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
    token                  = data.aws_eks_cluster_auth.cluster.token
    load_config_file       = false
  }
}
