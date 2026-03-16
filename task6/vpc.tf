##### CREATING VPC #####

resource "aws_vpc" "eks_vpc" {
    cidr_block = var.eks_vpc_cidr

    tags = {
        Name = "VPC for EKS task"
        "kubernetes.io/cluster/my-eks-cluster" = "shared"
    }
}


##### CREATING PUBLIC AND PRIVATE SUBNETS, 1 OF EACH IN EACH AZ #####

resource "aws_subnet" "eks_public_subnets" {
    for_each = zipmap(var.eks_azs, var.eks_pub_subnets)
    vpc_id = aws_vpc.eks_vpc.id
    availability_zone = each.key
    cidr_block = each.value

    tags = {
        "kubernetes.io/role/elb" = "1"
    }
}

resource "aws_subnet" "eks_private_subnets" {
    for_each = zipmap(var.eks_azs, var.eks_priv_subnets)
    vpc_id = aws_vpc.eks_vpc.id
    availability_zone = each.key
    cidr_block = each.value

    tags = {
        "kubernetes.io/role/internal-elb" = "1"
    }
}


##### CREATING INTERNET GATEWAY #####

resource "aws_internet_gateway" "eks_vpc_ig" {
    vpc_id = aws_vpc.eks_vpc.id

    tags = {
        Name = "Internet gateway for EKS VPC"
    }
}


##### CREATING EIPs FOR NAT GATEWAYS IN EACH PUBLIC SUBNET #####

resource "aws_eip" "eks_nat_eips" {
    count = 2
    domain = "vpc"

    tags = {
        Name = "EIP for NAT gateway in Public Subnet ${count.index + 1}"
    }
}


##### CREATING NAT GATEWAY, 1 IN EACH PUBLIC SUBNET #####

resource "aws_nat_gateway" "eks_nat_gw" {
    count = 2
    availability_mode = "zonal"
    allocation_id = element(aws_eip.eks_nat_eips[*].id, count.index)
    subnet_id =  aws_subnet.eks_public_subnets[var.eks_azs[count.index]].id

    tags = {
        Name = "NAT gateway for public subnet ${count.index + 1}"
    }
}


##### CREATING ROUTE TABLES FOR PUBLIC AND PRIVATE SUBNETS #####

resource "aws_route_table" "eks_pub_subnet_rt" {
    vpc_id = aws_vpc.eks_vpc.id
    route {
        cidr_block = local.internet_cidr
        gateway_id = aws_internet_gateway.eks_vpc_ig.id
    }

    tags = {
        Name = "Route table for public subnet"
    }
}

resource "aws_route_table" "eks_priv_subnet_rt" {
    count = 2
    vpc_id = aws_vpc.eks_vpc.id
    route {
        cidr_block = local.internet_cidr
        gateway_id = aws_nat_gateway.eks_nat_gw[count.index].id
    }

    tags = {
        Name = "Route table for private subnet ${count.index + 1}"
    }
}


##### CREATING ROUTE TABLE ASSOCIATIONS #####

resource "aws_route_table_association" "eks_pub_subnet_rt_asso" {
    count = 2
    subnet_id = aws_subnet.eks_public_subnets[var.eks_azs[count.index]].id
    route_table_id = aws_route_table.eks_pub_subnet_rt.id
}

resource "aws_route_table_association" "eks_priv_subnet_rt_asso" {
    count = 2
    subnet_id = aws_subnet.eks_private_subnets[var.eks_azs[count.index]].id
    route_table_id = aws_route_table.eks_priv_subnet_rt[count.index].id
}
