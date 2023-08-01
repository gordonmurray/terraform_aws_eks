# Kubernetes cluster on AWS EKS using Terraform

Before you begin, make sure you have the following installed:

* Terraform - version 1.1.8 [link](https://www.terraform.io/downloads.html)
* AWS CLI [link](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-welcome.html)
* Kubectl [link](https://kubernetes.io/docs/tasks/tools/)
* Helm [link](https://helm.sh/docs/intro/install/)

To create the cluster:

```
terraform init
terraform apply
```

Once terraform has created the cluster:

```
aws eks update-kubeconfig --name terraform-eks --profile=gordonmurray --region=eu-west-1
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
Project: gordonmurray/terraform_aws_eks

 Name                                                                                           Monthly Qty  Unit                    Monthly Cost

 module.my-cluster.aws_cloudwatch_log_group.this[0]
 ├─ Data ingested                                                                         Monthly cost depends on usage: $0.57 per GB
 ├─ Archival Storage                                                                      Monthly cost depends on usage: $0.03 per GB
 └─ Insights queries data scanned                                                         Monthly cost depends on usage: $0.0057 per GB

 module.my-cluster.aws_eks_cluster.this[0]
 └─ EKS cluster                                                                                         730  hours                         $73.00

 module.my-cluster.module.eks_managed_node_group["green"].aws_eks_node_group.this[0]
 └─ module.my-cluster.module.eks_managed_node_group["green"].aws_launch_template.this[0]
    ├─ Instance usage (Linux/UNIX, on-demand, t3.large)                                                 730  hours                         $66.58
    └─ EC2 detailed monitoring                                                                            7  metrics                        $2.10

 module.my-cluster.module.kms.aws_kms_key.this[0]
 ├─ Customer master key                                                                                   1  months                         $1.00
 ├─ Requests                                                                              Monthly cost depends on usage: $0.03 per 10k requests
 ├─ ECC GenerateDataKeyPair requests                                                      Monthly cost depends on usage: $0.10 per 10k requests
 └─ RSA GenerateDataKeyPair requests                                                      Monthly cost depends on usage: $0.10 per 10k requests

 OVERALL TOTAL                                                                                                                            $142.68
──────────────────────────────────
39 cloud resources were detected:
∙ 4 were estimated, 2 of which include usage-based costs, see https://infracost.io/usage-file
∙ 35 were free:
  ∙ 11 x aws_security_group_rule
  ∙ 6 x aws_iam_role_policy_attachment
  ∙ 3 x aws_subnet
  ∙ 2 x aws_iam_role
  ∙ 2 x aws_route_table_association
  ∙ 2 x aws_security_group
  ∙ 1 x aws_ec2_tag
  ∙ 1 x aws_iam_openid_connect_provider
  ∙ 1 x aws_iam_policy
  ∙ 1 x aws_internet_gateway
  ∙ 1 x aws_kms_alias
  ∙ 1 x aws_launch_template
  ∙ 1 x aws_route
  ∙ 1 x aws_route_table
  ∙ 1 x aws_vpc
```