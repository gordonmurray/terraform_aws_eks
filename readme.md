# Kubernetes cluster on AWS EKS using Terraform

Before you begin, make sure you have the following installed:

* Terraform - version 0.14.5 [link](https://www.terraform.io/downloads.html)
* AWS CLI [link](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-welcome.html)
* Kubectl [link](https://kubernetes.io/docs/tasks/tools/)
* ArgoCD CLI [link](https://argoproj.github.io/argo-cd/cli_installation/)

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

Add a context to ArgoCD

```
argocd cluster add {context}
```

add --port-forward-namespace argocd flag to every CLI command:

```
export ARGOCD_OPTS='--port-forward-namespace argocd'
```

Deploy Guestbook application

```
argocd app create guestbook --repo https://github.com/argoproj/argocd-example-apps.git --path guestbook --dest-server https://kubernetes.default.svc --dest-namespace default
```

App status 

```
argocd app get guestbook
```

Sync app

```
argocd app sync guestbook
```