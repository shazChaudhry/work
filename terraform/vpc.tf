module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.domain}"
  cidr = "${var.vpc_cidr_blocks}"

  azs             = ["${data.aws_availability_zones.all.names}"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway   = true
  enable_vpn_gateway   = true
  enable_dns_hostnames = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
