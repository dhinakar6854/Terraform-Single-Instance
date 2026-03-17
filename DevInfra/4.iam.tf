module "dev_iam_1" {
  source              = "../modules/4.iam"
  env                 = module.dev_vpc_1.environment
  rolename            = "devopsb3334testrole"
  instanceprofilename = "devopsb3334instprofile"
  iam_policy_name     = "devopsb3334-iampolicy"
}