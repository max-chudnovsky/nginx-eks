# Description
Terraform Module that sets up an EKS cluster and deploys NGINX with a load balancer.

# Prerequisites
- terraform
- aws-cli
- Set up Terraform to ensure your AWS credentials point to an IAM Role that has access to deployment and management of the EKS cluster, creation of VPC, spinning EC2, etc.

# Installation
```
git clone https://github.com/max-chudnovsky/nginx-eks.git
cd nginx-eks
terraform init
```
- OPTIONAL.  Modify variables.tf and terraform.tfvars if so desired
  
```terraform apply```

# Test
```
# Let's point our kubectl to our new cluster
max@master:~/terraform/hiive-test$ aws eks update-kubeconfig --region us-east-1 --name hiive-test
Updated context arn:aws:eks:us-east-1:409367258773:cluster/hiive-test in /home/max/.kube/config

# Let's get our load balancer's IP addr
max@master:~/terraform/hiive-test$ kubectl get svc nginx
NAME    TYPE           CLUSTER-IP       EXTERNAL-IP                                                              PORT(S)        AGE
nginx   LoadBalancer   172.20.250.178   afceffcfa4fe04aafa6ee441086514d1-988735755.us-east-1.elb.amazonaws.com   80:30502/TCP   2m6s

# Finally, lets hit the default web page
max@master:~/terraform/hiive-test$ curl afceffcfa4fe04aafa6ee441086514d1-988735755.us-east-1.elb.amazonaws.com
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
```
