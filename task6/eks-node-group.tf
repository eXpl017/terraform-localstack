resource "aws_launch_template" "eks_node_lt" {
  name        = "eks-node-launch-template"
  description = "Launch template for EKS worker nodes"

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size           = 40
      volume_type           = "gp3"
      delete_on_termination = true
    }
  }

  monitoring {
    enabled = true
  }

  user_data = base64encode(<<-EOF
        #!/bin/bash
        echo "Node started" > /tmp/node-init.log
        EOF
  )

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "EKS Worker Node"
    }
  }

  tags = {
    Name = "EKS Launch Template"
  }
}

resource "aws_eks_node_group" "eks_node_group" {
  node_group_name = "my-eks-node-group"
  cluster_name    = aws_eks_cluster.my_cluster.name
  node_role_arn   = aws_iam_role.eks_node_role.arn

  subnet_ids = values(aws_subnet.eks_private_subnets)[*].id

  scaling_config {
    desired_size = 2
    min_size     = 1
    max_size     = 3
  }

  launch_template {
    id      = aws_launch_template.eks_node_lt.id
    version = "$Latest"
  }

  ami_type       = "AL2_x86_64"
  capacity_type  = "ON_DEMAND"
  instance_types = ["t3.medium"]
  version        = "1.35.2"
}
