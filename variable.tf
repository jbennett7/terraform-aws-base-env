variable "vpc_name" {
  type = string
  description = "Name of the VPC for the environment."
}
variable "vpc_cidr" {
  type = string
  description = "Ensure the CIDR block reserved for this VPC does not overlap with other networks."
}
variable "number_of_availability_zones" {
  type = number
  description = "The number of availability zones to use."
}
variable "private_subnets" {
  type = list(string)
  description = "The private subnet cidr block."
}
variable "public_subnets" {
  type = list(string)
  description = "The public subnet cidr block."
}
variable "enable_nat_gateway" {
  type = bool
  default = false
  description = "Enable a NAT gateway."
}
variable "enable_vpn_gateway" {
  type = bool
  default = false
  description = "Enable a VPN gateway."
}
variable "tags" {
  type = map(string)
  default = {}
  description = "Tags to assign to all resources used."
}
variable "bastion_name" {
  type = string
  description = "The name of the bastion host."
}
variable "monitoring" {
  type = bool
  default = false
  description = "Enable monitoring for the bastion host."
}
variable "region" {
  type = string
  default = "us-east-1"
  description = "The region to deploy the resources in."
}
variable "profile" {
  type = string
  default = "default"
  description = "The profile to use when deploying the resources."
}
variable "public_key_path" {
  type = string
  description = "SSH public key path."
}
variable "ami_owners" {
  type = list(string)
  default = ["amazon"]
  description = "The owner of the ami to use when deploying the bastion host."
}
variable "ami_filter_name_values" {
  type = list(string)
  default = ["amzn2-ami-hvm-*-x86_64-*"]
  description = "The filter to apply when selecting the ami."
}
variable "bastion_ingress_cidr_blocks" {
  type = list
  description = "The bastion host ingress cidr to apply for ssh access."
}
variable "bastion_host_instance_type" {
  type = string
  default = "t2.micro"
  description = "The instance type used for the bastion host."
}
