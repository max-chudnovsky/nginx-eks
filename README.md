# Setup terraform to ensure your AWS credentuals point to IAM Role that has access to deployment and management of EKS cluster.

Action	IAM Permissions Needed (AWS Managed Policies)
EKS cluster management	AmazonEKSClusterPolicy, AmazonEKSServicePolicy, AmazonEC2FullAccess, IAMFullAccess, AutoScalingFullAccess, ElasticLoadBalancingFullAccess
Deploy to EKS with kubectl	eks:DescribeCluster, sts:GetCallerIdentity + mapped to Kubernetes admin group (system:masters or cluster-admin)

# git clone repository

# terraform init
# modify variables.tf and terraform.tfvars if so desire.  optional.
# terraform apply

# test
max@master:~/terraform/hiive-test$ aws eks update-kubeconfig --region us-east-1 --name hiive-test
Updated context arn:aws:eks:us-east-1:409367258773:cluster/hiive-test in /home/max/.kube/config
max@master:~/terraform/hiive-test$ kubectl get svc nginx
NAME    TYPE           CLUSTER-IP       EXTERNAL-IP                                                              PORT(S)        AGE
nginx   LoadBalancer   172.20.250.178   afceffcfa4fe04aafa6ee441086514d1-988735755.us-east-1.elb.amazonaws.com   80:30502/TCP   2m6s
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