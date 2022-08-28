locals {
  nonprod_envs = toset(["dev", "qa"])
  prod_envs    = toset(["prod"])
  environments = setunion(local.nonprod_envs, local.prod_envs)
  region       = "us-east-1"
}