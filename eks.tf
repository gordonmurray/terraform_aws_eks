data "aws_eks_cluster" "cluster" {
  name = module.my-cluster.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.my-cluster.cluster_id
}

module "my-cluster" {
  # https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/18.26.6
  source          = "terraform-aws-modules/eks/aws"
  version         = "19.15.4"
  cluster_name    = "terraform-eks"
  cluster_version = "1.27"
  subnet_ids      = [aws_subnet.subnet-1a.id, aws_subnet.subnet-1b.id]
  vpc_id          = aws_vpc.vpc.id

  eks_managed_node_groups = {

    green = {
      min_size     = 1
      max_size     = 3
      desired_size = 1

      instance_types = ["t3.large"]
      capacity_type  = "SPOT"
      labels = {
        Environment = "test"
      }

    }
  }

  tags = {
    Repo = "terraform_aws_eks"
  }
}
