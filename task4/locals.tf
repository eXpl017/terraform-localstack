locals {
  vpc_config = data.terraform_remote_state.vpc.outputs
  vpc_id     = local.vpc_config.vpc_id
  subnet_ids = {
    public = slice(local.vpc_config.subnets_info.public_subnets_ids, 0, 2)
  }
}
