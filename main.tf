data "aws_eks_cluster" "cluster" {
  name = module.my-cluster.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.my-cluster.cluster_id
}

provider "aws" {
  version = "3.7.0"
  profile = "default"
  region  = "eu-west-1"
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
  version                = "~> 1.9"
}

module "my-cluster" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "gordon-terraform-eks"
  cluster_version = "1.17"
  subnets         = ["subnet-3d94594a", "subnet-228d6d7b", "subnet-97983ff2"]
  vpc_id          = "vpc-8704fae2"

  worker_groups = [
    {
      instance_type      = "m5.large"
      asg_max_size       = 3
      spot_price         = "0.0369"
      kubelet_extra_args = "--node-labels=node.kubernetes.io/lifecycle=spot"
    }
  ]
}
