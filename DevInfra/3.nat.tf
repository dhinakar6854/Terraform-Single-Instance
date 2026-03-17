module "dev_natgw_1" {
  source           = "../modules/3.nat"
  public_subnet_id = module.dev_vpc_1.public_subnets_id_1
  vpc_name         = module.dev_vpc_1.vpc_name
  private_rt_id    = module.dev_vpc_1.private_route_table_id
}