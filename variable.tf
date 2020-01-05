variable "vpc_name" {
  type = string
}
variable "vpc_cidr" {
  type = string
}
variable "number_of_availability_zones" {
  type = number
}
variable "private_subnets" {
  type = list(string)
}
variable "public_subnets" {
  type = list(string)
}
variable "enable_nat_gateway" {
  type = bool
  default = false
}
variable "enable_vpn_gateway" {
  type = bool
  default = false
}
variable "tags" {
  type = map(string)
  default = {}
}
variable "bastion_name" {
  type = string
}
variable "monitoring" {
  type = bool
  default = false
}
variable "region" {
  type = string
  default = "us-east-1"
}
variable "profile" {
  type = string
  default = "default"
}
variable "public_key_path" {
  type = string
}
variable "ami_owners" {
  type = list(string)
  default = ["amazon"]
}
variable "ami_filter_name_values" {
  type = list(string)
  default = ["amzn2-ami-hvm-*-x86_64-*"]
}
variable "bastion_ingress_cidr_blocks" {
  type = list
}
variable "bastion_host_instance_type" {
  type = string
  default = "t2.micro"
}
