locals {
  req_info       = data.terraform_remote_state.alb.outputs
  alb_arn        = local.req_info.alb_info["arn"]
  app_serv_sg_id = local.req_info.generic_info["app_serv_sg_id"]
  app_tg_grp_arn = local.req_info.generic_info["tg_arn"]

  instance_profile = data.terraform_remote_state.iam_prof.outputs.instance_profile_id

  vpc_config      = data.terraform_remote_state.vpc.outputs
  private_subnets = slice(local.vpc_config.subnets_info.private_subnets_ids, 0, 2)
}
