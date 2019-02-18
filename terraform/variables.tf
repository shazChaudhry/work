variable "region" {
  default = "eu-west-2"
}

variable "credentials" {
  default = "~/.aws/credentials"
}

variable "DnsZoneName" {
  default = "schaudhry.com"
}

variable "domain" {
  default = "proxy"
}

variable "disk_size_gb" {
  default = 20
}

variable "instance_type" {
  default = "t2.medium.elasticsearch"
}

variable "instance_count" {
  default = 4
}

variable "vpc_cidr_blocks" {
  default = "10.0.0.0/16"
}
