variable "name_prefix" {
  type        = string
  description = "Prefix to be used on each infrastructure object Name created in AWS."
}

variable "developer_users" {
  type        = list(string)
  description = "List of Kubernetes developers."
}

variable "admin_users" {
  type        = list(string)
  description = "List of Kubernetes admins."
}

variable "asg_instance_types" {
  type        = list(string)
  description = "List of EC2 instance machine types to be used in EKS."
}

variable "autoscaling_minimum_size_by_az" {
  type        = number
  description = "Minimum number of EC2 instances to autoscale our EKS cluster on each AZ."
}

variable "autoscaling_maximum_size_by_az" {
  type        = number
  description = "Maximum number of EC2 instances to autoscale our EKS cluster on each AZ."
}

variable "autoscaling_average_cpu" {
  type        = number
  description = "Average CPU threshold to autoscale EKS EC2 instances."
}

variable "spot_termination_handler_chart_name" {
  type        = string
  description = "EKS Spot termination handler Helm chart name."
}

variable "spot_termination_handler_chart_repo" {
  type        = string
  description = "EKS Spot termination handler Helm repository name."
}

variable "spot_termination_handler_chart_version" {
  type        = string
  description = "EKS Spot termination handler Helm chart version."
}

variable "spot_termination_handler_chart_namespace" {
  type        = string
  description = "Kubernetes namespace to deploy EKS Spot termination handler Helm chart."
}

# get all available AZs in our region
data "aws_availability_zones" "available_azs" {
  state = "available"
}

data "aws_caller_identity" "current" {} # used for accesing Account ID and ARN
