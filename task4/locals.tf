locals {
  vpc_config = data.terraform_remote_state.vpc.outputs
  vpc_id     = local.vpc_config.vpc_info.id
  subnet_ids = {
    public = slice(local.vpc_config.subnets_info.public_subnets_ids, 0, 2)
  }

  app_serv_info         = data.terraform_remote_state.instances.outputs
  app_serv_sg_id        = local.app_serv_info.sg_ids["app_serv_sg"]
  app_serv_instance_ids = values(local.app_serv_info.app_serv_priv_ip)

}
