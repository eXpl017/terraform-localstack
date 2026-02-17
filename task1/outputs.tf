output "vpc_info" {
    description ="VPC ID and CIDR block"
    value = {
        id = aws_vpc.main.id
        cidr_block = aws_vpc.main.cidr_block
    }
}

output "subnets_info" {
    description = "Subnet IDs"
    value = {
        public_subnets_ids = aws_subnet.public_subnets[*].id
        private_subnets_ids = aws_subnet.private_subnets[*].id
    }
}


output "gateway_info" {
    description = "Internet and NAT Gateway info"
    value = {
        internet_gw = aws_internet_gateway.gw.id
        nat_gw = aws_nat_gateway.nat_gw[*].id
    }
}


output "rt_info" {
    description = "Route Table IDs"
    value = {
        public_rt = aws_route_table.public_rt.id
        private_rt = aws_route_table.private_rt[*].id
    }
}
/*
output "" {
    description =""
    value = 
}

output "" {
    description =""
    value = 
}
*/
