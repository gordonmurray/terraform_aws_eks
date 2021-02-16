data "aws_eks_cluster" "cluster" {
  name = module.my-cluster.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.my-cluster.cluster_id
}

module "my-cluster" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "gordon-terraform-eks"
  cluster_version = "1.17"
  subnets         = ["subnet-0c91cf75e5da4c2a8", "subnet-03fdb36029c4ce2cd"]
  vpc_id          = "vpc-07786849f225d751a"

  worker_groups = [
    {
      instance_type      = "m5.large"
      asg_max_size       = 3
      spot_price         = "0.0370"
      kubelet_extra_args = "--node-labels=node.kubernetes.io/lifecycle=spot"
    }
  ]

  workers_group_defaults = {
    root_volume_type = "gp2"
  }
}
