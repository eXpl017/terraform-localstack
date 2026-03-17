resource "aws_eks_cluster" "my_cluster" {
  name                      = "my-eks-cluster"
  role_arn                  = aws_iam_role.eks_cluster_role.arn
  enabled_cluster_log_types = ["api", "audit", "authenticator"]
  version                   = "1.35.2"

  vpc_config {
    subnet_ids = concat(
      values(aws_subnet.eks_private_subnets)[*].id,
      values(aws_subnet.eks_public_subnets)[*].id
    )
    endpoint_public_access  = true
    endpoint_private_access = true
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy
  ]

  tags = {
    Name = "My EKS Cluster"
  }
}
