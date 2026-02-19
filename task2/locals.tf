locals {
  ami_id     = data.aws_ami.amazon_linux.id
  vpc_config = data.terraform_remote_state.vpc.outputs
  vpc_id     = local.vpc_config.vpc_info.id
  subnet_ids = {
    public  = local.vpc_config.subnets_info.public_subnets_ids[0]
    private = local.vpc_config.subnets_info.private_subnets_ids[0]
  }
}
