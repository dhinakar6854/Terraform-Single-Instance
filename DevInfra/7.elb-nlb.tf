module "dev_elb_1" {
  source          = "../modules/7.elb-nlb"
  env             = module.dev_vpc_1.environment
  nlbname         = var.nlbname
  subnets         = module.dev_vpc_1.public_subnets_id
  tgname          = var.nlbtgname
  vpc_id          = module.dev_vpc_1.vpc_id
  private_servers = module.dev_compute_1.private_servers
  #*.awsb40.xyz Certificate ARN
  certificate_arn = var.alb_certificate_arn
}


