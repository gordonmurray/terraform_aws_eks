# Kubernetes cluster on AWS EKS using Terraform

[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/gordonmurray/gordon-terraform-eks/iso)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=gordonmurray%2Fgordon-terraform-eks&benchmark=ISO27001) [![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/gordonmurray/gordon-terraform-eks/soc2)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=gordonmurray%2Fgordon-terraform-eks&benchmark=SOC2) [![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/gordonmurray/gordon-terraform-eks/cis_kubernetes)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=gordonmurray%2Fgordon-terraform-eks&benchmark=CIS+KUBERNETES+V1.5)

Before you begin, make sure you have the following installed:

* Terraform - version 0.14.5 [link](https://www.terraform.io/downloads.html)
* AWS CLI [link](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-welcome.html)
* Kubectl [link](https://kubernetes.io/docs/tasks/tools/)

To create the cluster:

```
terraform init
terraform apply
```

Once terraform has created the cluster:

```
aws eks update-kubeconfig --name gordon-terraform-eks --profile=default --region=eu-west-1 
```

You should see an output similar to :

> Added new context arn:aws:eks:eu-west-1:016230046494:cluster/gordon-terraform-eks to /home/gordon/.kube/config

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
 Name                                                           Quantity  Unit            Monthly Cost 
                                                                                                       
 module.my-cluster.aws_autoscaling_group.workers[0]                                                    
 └─ module.my-cluster.aws_launch_configuration.workers[0]                                              
    ├─ Instance usage (Linux/UNIX, spot, t3.large)                   730  hours                 $20.44 
    ├─ EC2 detailed monitoring                                         7  metrics                $2.10 
    ├─ CPU credits                                         Cost depends on usage: $0.05 per vCPU-hours 
    └─ root_block_device                                                                               
       └─ Storage (general purpose SSD, gp2)                         100  GB-months             $11.00 
                                                                                                       
 module.my-cluster.aws_eks_cluster.this[0]                                                             
 └─ EKS cluster                                                      730  hours                 $73.00 
                                                                                                       
 PROJECT TOTAL                                                                                 $106.54 
```

