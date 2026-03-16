##### VPC RELATED VARIABLES #####

variable "eks_vpc_cidr" {
    type = string
    description = "CIDR range for EKS VPC"
    default = "10.0.0.0/16"
}

variable "eks_azs" {
    type = list(string)
    description = "AZs in the EKS VPC"
    default = [
        "us-east-1a",
        "us-east-1b"
    ]
}

variable "eks_pub_subnets" {
    type = list(string)
    description = "List of public subnets in EKS cluster"
    default = [
        "10.0.1.0/24",
        "10.0.2.0/24"
    ]
}

variable "eks_priv_subnets" {
    type = list(string)
    description = "List of private subnets in EKS cluster"
    default = [
        "10.0.11.0/24",
        "10.0.12.0/24"
    ]
}

###############################


