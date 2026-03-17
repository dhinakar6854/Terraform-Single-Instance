module "dev_route53_1_nlb" {
  source     = "../modules/8.route53"
  domainname = var.domainname
  nlb_id     = module.dev_elb_1.elb_id
  dns_name   = module.dev_elb_1.elb_dns_name
  zone_id    = module.dev_elb_1.elb_zone_id
  recordname = "nlb"
}

module "dev_route53_1_alb" {
  source     = "../modules/8.route53"
  domainname = var.domainname
  nlb_id     = module.dev_elb_alb_1.elb_id
  dns_name   = module.dev_elb_alb_1.elb_dns_name
  zone_id    = module.dev_elb_alb_1.elb_zone_id
  recordname = "alb"
}