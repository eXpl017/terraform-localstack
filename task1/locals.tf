locals {
    common_tags = {
        Environment = var.environ
        ManagedBy = "Terraform"
        Project = var.proj_name
    }
    az_count = length(var.azs)
    internet_cidr = "0.0.0.0/0"
}
