# Kubernetes cluster on AWS EKS using Terraform

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

Port forward to load the ArgoCD UI in the browser

```
kubectl port-forward svc/argocd-server -n argocd 8080:443
```
