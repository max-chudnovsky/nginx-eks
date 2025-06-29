# # This Terraform configuration sets up an EKS cluster with managed node groups.
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.37.1"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  # Kubernetes cluster configuration.  Open the cluster to public and private access.  DO NOT DO THIS IN REAL ENVIRONMENT :)  
  # I just do not want to set up a bastion host for this test and needed access with kubectl..etc.
  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true
  enable_cluster_creator_admin_permissions = true

  # IAM role for the EKS cluster
  access_entries = {
    eks_admin = {
      principal_arn     = "arn:aws:iam::409367258773:user/terraform"
      kubernetes_groups = ["cluster-admin"]
      policy_associations = []
    }
  }

  cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }
  
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # Node group configuration
  eks_managed_node_groups = {
    default = {
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = var.node_instance_types
      capacity_type  = "SPOT"
      min_size       = var.min_size
      max_size       = var.max_size
      desired_size   = var.desired_size
    }
  }

  tags = var.tags
}