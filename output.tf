output "vpc_id" {
  value = module.vpc.vpc_id
  description = "Application's VPC ID."
}

output "public_subnets" {
  value = module.vpc.public_subnets
  description = "Public subnets of the VPC."
}

output "private_subnets" {
  value = module.vpc.private_subnets
  description = "Private subnets of the VPC."
}

output "packer_build_security_group_id" {
  value = module.packer_build_security_group.this_security_group_id
  description = "Security group used by Packer to build images."
}

output "packer_build_ssh_key_name" {
  value = module.packer_build_key_pair.this_key_pair_key_name
  description = "SSH key used by Packer to build images."
}
