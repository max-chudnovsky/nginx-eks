module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.37.1"

  cluster_name    = "${local.name}"
  cluster_version = "1.33" # lets use latest EKS version to future-proof this example

  # just for a this test so i dont need to spin up bastion EC2 host, not recommended for real environments
  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true
  enable_cluster_creator_admin_permissions = true

  access_entries = {
  eks_admin = {
    principal_arn     = "arn:aws:iam::409367258773:user/terraform"
    kubernetes_groups = ["cluster-admin"]
    policy_associations = []
  }
}

  # EKS Addons.  We can also hardcode versions here, but the module will use the latest version by default.
  cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {
    default = {
      # Starting on 1.33, AL2023_x86_64_STANDARD is the default AMI type for EKS managed node groups
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t3.medium"]
      capacity_type = "SPOT"

      min_size = 2
      max_size = 5
      # This value is ignored after the initial creation
      # https://github.com/bryantbiggs/eks-desired-size-hack
      desired_size = 2
    }
  }

  tags = local.tags
}
