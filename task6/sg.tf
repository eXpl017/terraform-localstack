##### SECURITY GROUP FOR NODES #####

resource "aws_security_group" "eks_node_sg" {
    name = ""
    description = ""
    vpc_id = ""

    tags = {
        Name = "EKS nodes security group"
        "kubernetes.io/cluster/my-eks-cluster" = "owned"
    }
}

resource "aws_vpc_security_group_egress_rule" "eks_node_egress_rule" {
    security_group_id = aws_security_group.eks_node_sg.id
    description = "Egress rule to allow all outbound communications"

    cidr_ipv4 = local.internet_cidr
    protocol = "-1"
}

resource "aws_vpc_security_group_ingress_rule" "eks_node_internal_comm" {
    security_group_id = aws_security_group.eks_node_sg.id
    description = "Ingress rule to allow all inter-node communications"

    referenced_security_group_id = aws_security_group.eks_node_sg.id
    protocol = "-1"
}

# resource "aws_vpc_security_group_ingress_rule" "eks_node_cluster_comm" {
#     security_group_id = aws_security_group.eks_node_sg.id
#     description = "Ingress rule to allow all communications between cluster and node"
# 
#     referenced_security_group_id = <CLUSTER CREATED SG HERE>
#     protocol = "-1"
# }
