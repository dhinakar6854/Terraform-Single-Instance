module "dev_sg_1" {
  source        = "../modules/2.sg"
  vpc_name      = module.dev_vpc_1.vpc_name
  vpc_id        = module.dev_vpc_1.vpc_id
  environment   = module.dev_vpc_1.environment
  service_ports = ["80", "443", "22", "3389", "3306"]
}

#To Access Output Value Of Another Modules
# module.<module-name>.<output-name>
#eg: module.dev_vpc_1.vpc_id