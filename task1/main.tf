resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "Practice Project"
  }
}

resource "aws_subnet" "public_subnets" {
  count             = length(var.public_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.public_subnet_cidrs, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "Public Subnet ${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnets" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.private_subnet_cidrs, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "Private Subnet ${count.index + 1}"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Test VPC GW"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Route Table for Public Subnets"
  }
}

resource "aws_route_table_association" "public_subnet_asso" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_eip" "nat" {
  count  = length(var.public_subnet_cidrs)
  domain = "vpc"

  tags = {
    Name = "Elastic IP for NAT Gateway ${count.index + 1}"
  }

  depends_on = [aws_internet_gateway.gw]
}

resource "aws_nat_gateway" "nat_gw" {
  count         = length(var.public_subnet_cidrs)
  allocation_id = element(aws_eip.nat[*].id, count.index)
  subnet_id     = element(aws_subnet.public_subnets[*].id, count.index)

  tags = {
    Name = "NAT Gateway for Public Subnet ${count.index + 1}"
  }

  depends_on = [aws_internet_gateway.gw]
}

resource "aws_route_table" "private_rt" {
    count = length(aws_subnet.private_subnets)
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = element(aws_nat_gateway.nat_gw[*].id, count.index)
    }

    tags = {
        Name = "Route Table for Private Subnet ${count.index + 1}"
    }
}

resource "aws_route_table_association" "private_subnet_asso" {
    count = length(aws_subnet.private_subnets)
    subnet_id = element(aws_subnet.private_subnets[*].id, count.index)
    route_table_id = element(aws_route_table.private_rt[*].id, count.index)
}
