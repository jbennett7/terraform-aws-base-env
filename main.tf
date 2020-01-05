#TODO: Secretly generate the private key material and store it in ssm.
#TODO: Plan for encryption.
#TODO: Bastion host should be in an autoscaling  group of one in two availability zones.

provider "aws" {
  region = var.region
  profile = var.profile
}

terraform {
  required_version = "> 0.12.0"
}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_ami" "bastion_ami" {
  owners = ["amazon"]
  most_recent = true
  filter {
    name = "name"
    values = var.ami_filter_name_values
  }
}

module "vpc" {
  source = "github.com/terraform-aws-modules/terraform-aws-vpc"
  name = var.vpc_name
  cidr = var.vpc_cidr
  azs = slice(data.aws_availability_zones.available.names, 0, var.number_of_availability_zones - 1)
  private_subnets = var.private_subnets
  public_subnets = var.public_subnets
  enable_nat_gateway = var.enable_nat_gateway
  enable_vpn_gateway = var.enable_vpn_gateway
  tags = var.tags
}

module "bastion_key_pair" {
  source = "github.com/terraform-aws-modules/terraform-aws-key-pair"
  key_name = "bastion_host"
  public_key = file(var.public_key_path)
}

module "bastion_security_group" {
  source = "github.com/terraform-aws-modules/terraform-aws-security-group//modules/ssh"
  name = "bastion-security-group"
  description = "Security group for the bastion host."
  vpc_id = module.vpc.vpc_id
  ingress_cidr_blocks = var.bastion_ingress_cidr_blocks
}

module "bastion_host" {
  source = "github.com/terraform-aws-modules/terraform-aws-ec2-instance"
  name = var.bastion_name
  ami = data.aws_ami.bastion_ami.id
  instance_count = 1
  instance_type = var.bastion_host_instance_type
  key_name = module.bastion_key_pair.this_key_pair_key_name
  monitoring = var.monitoring
  vpc_security_group_ids = [module.bastion_security_group.this_security_group_id]
  subnet_id = module.vpc.public_subnets[0]
  tags = var.tags
}
