# Kubernetes cluster on AWS EKS using Terraform

Before you begin, make sure you have the following installed:

* Terraform - version 1.1.8 [link](https://www.terraform.io/downloads.html)
* AWS CLI [link](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-welcome.html)
* Kubectl [link](https://kubernetes.io/docs/tasks/tools/)

To create the cluster:

```
terraform init
terraform apply
```

Once terraform has created the cluster:

```
aws eks update-kubeconfig --name terraform-eks --profile=default --region=eu-west-1
```

You should see an output similar to :

> Added new context arn:aws:eks:eu-west-1:016230046494:cluster/terraform-eks to /home/gordon/.kube/config

Try out some Kubectl commands:

```
kubectl get nodes
kubectl get pods --all-namespaces
```

List current cluster contexts

```
kubectl config get-contexts -o name
```

## Estimated cost, using [Infracost](https://github.com/infracost/infracost)

```
Project: gordonmurray/terraform_aws_eks/.

 Name                                                                                        Monthly Qty  Unit              Monthly Cost

 module.my-cluster.aws_cloudwatch_log_group.this[0]
 ├─ Data ingested                                                                         Monthly cost depends on usage: $0.57 per GB
 ├─ Archival Storage                                                                      Monthly cost depends on usage: $0.03 per GB
 └─ Insights queries data scanned                                                         Monthly cost depends on usage: $0.0057 per GB

 module.my-cluster.aws_eks_cluster.this[0]
 └─ EKS cluster                                                                                      730  hours                   $73.00

 module.my-cluster.module.eks_managed_node_group["green"].aws_eks_node_group.this[0]
 └─ module.my-cluster.module.eks_managed_node_group["green"].aws_launch_template.this[0]
    ├─ Instance usage (Linux/UNIX, on-demand, )                                                      730  hours                    $0.00
    └─ EC2 detailed monitoring                                                                         7  metrics                  $2.10

 OVERALL TOTAL                                                                                                                    $75.10
──────────────────────────────────
37 cloud resources were detected, rerun with --show-skipped to see details:
∙ 3 were estimated, 2 include usage-based costs, see https://infracost.io/usage-file
∙ 34 were free
```