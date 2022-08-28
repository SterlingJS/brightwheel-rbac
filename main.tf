module "environments" {
  for_each    = local.environments
  source      = "./modules/foundation"
  environment = each.key
}