variable "vpc_cidr_block" {
    type = string
    description = "CIDR range for our VPC"
    default = "10.0.0.0/16"
}

variable "aws_region" {
    type = string
    description = "AWS region for VPC and resources"
    default = "us-east-1"
}

variable "proj_name" {
    type = string
    description = "Name of project for tagging"
    default = "practice-proj"
}

variable "environ" {
    type = string
    description = "SDLC environment the project changes deploy to"
    default = "dev"

    validation {
        condition = contains(["dev","staging","prod"], var.environ)
        error_message = "Environment must be either dev, staging or prod"
    }
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Public Subnet CIDR values"
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Private Subnet CIDR values"
  default     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

variable "azs" {
  type        = list(string)
  description = "Availability Zones for us-east-1"
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}
