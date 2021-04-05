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

Install ArgoCD

```
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

Change the argocd-server service type to LoadBalancer:

```
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
```

Port forward to get the ArgoCD UI

```
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

Log in using the CLI

```
# get password
kubectl get pods -n argocd -l app.kubernetes.io/name=argocd-server -o name | cut -d'/' -f 2
argocd login localhost:8080

# change password
argocd account update-password
```

List current cluster contexts

```
kubectl config get-contexts -o name
```

## Estimated cost, using Infracost

```
  NAME                                                      MONTHLY QTY  UNIT       PRICE   HOURLY COST  MONTHLY COST  

  module.my-cluster.aws_autoscaling_group.workers[0]                                                                   
  └─ module.my-cluster.aws_launch_configuration.workers[0]  
     ├─ Linux/UNIX usage (spot, m5.large)                           730  hours      0.0368       0.0368       26.8640  
     ├─ EBS-optimized usage                                         730  hours      0.0000       0.0000        0.0000  
     ├─ EC2 detailed monitoring                                       7  metrics    0.3000       0.0029        2.1000  
     └─ root_block_device                                   
        └─ General Purpose SSD storage (gp2)                        100  GB-months  0.1100       0.0151       11.0000  
  Total                                                                                          0.0547       39.9640  
                                                                                                                       
  module.my-cluster.aws_eks_cluster.this[0]                                                                            
  └─ EKS cluster                                                    730  hours      0.1000       0.1000       73.0000  
  Total                                                                                          0.1000       73.0000  
                                                                                                                       
  OVERALL TOTAL (USD)                                                                            0.1547      112.9640  
  ```

