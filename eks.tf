data "aws_eks_cluster" "cluster" {
  name = module.my-cluster.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.my-cluster.cluster_id
}

module "my-cluster" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "terraform-eks"
  cluster_version = "1.19"
  subnets         = [aws_subnet.subnet-1a.id, aws_subnet.subnet-1b.id]
  vpc_id          = aws_vpc.vpc.id

  worker_groups = [
    {
      instance_type      = "t3.large"
      asg_max_size       = 2
      spot_price         = "0.02900"
      kubelet_extra_args = "--node-labels=node.kubernetes.io/lifecycle=spot"
    }
  ]

  workers_group_defaults = {
    root_volume_type = "gp2"
  }
}
