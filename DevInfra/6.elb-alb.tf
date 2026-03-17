module "dev_elb_alb_1" {
  source          = "../modules/6.elb-alb"
  albname         = var.albname
  sg_id           = module.dev_sg_1.sg_id
  subnets         = module.dev_vpc_1.public_subnets_id
  env             = module.dev_vpc_1.environment
  albtgname       = var.albtgname
  vpc_id          = module.dev_vpc_1.vpc_id
  private_servers = module.dev_compute_1.private_servers
  #*.awsb46.xyz Certificate ARN
  alb_certificate_arn = var.alb_certificate_arn
}