provider "aws" {
  region  = var.region
  profile = var.profile
}

terraform {
  required_version = "> 0.12.0"
  backend "s3" {
    encrypt = true
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source = "github.com/terraform-aws-modules/terraform-aws-vpc"

  name               = var.vpc_name
  cidr               = var.vpc_cidr
  azs                = slice(data.aws_availability_zones.available.names, 0, var.number_of_availability_zones - 1)
  private_subnets    = var.private_subnets
  public_subnets     = var.public_subnets
  enable_nat_gateway = var.enable_nat_gateway
  enable_vpn_gateway = var.enable_vpn_gateway
  tags               = var.tags
}

module "packer_build_key_pair" {
  source = "github.com/terraform-aws-modules/terraform-aws-key-pair"

  key_name = "packer_build"
  public_key = file(var.public_key_path)
}

module "packer_build_security_group" {
  source = "github.com/terraform-aws-modules/terraform-aws-security-group//modules/ssh"

  name = "packer-build-security-group"
  description = "Security group for building packer images."
  vpc_id = module.vpc.vpc_id
  ingress_cidr_blocks = var.packer_build_ingress_cidr_blocks
}
