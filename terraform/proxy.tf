module "poxy" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "1.14.0"

  ami                         = "${data.aws_ami.ami.id}"
  instance_type               = "t2.small"
  iam_instance_profile        = "shaz"
  name                        = "proxy"
  associate_public_ip_address = true
  vpc_security_group_ids      = ["${aws_security_group.proxy_sg.id}"]
  key_name                    = "personal"
  subnet_id                   = "${module.vpc.public_subnets[0]}"

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y epel-release
              yum install -y nginx
              service nginx start
              EOF

  tags = {
    Name        = "proxy"
    Environment = "dev"
  }

  volume_tags = {
    Name        = "proxy"
    Environment = "dev"
  }
}

resource "aws_route53_record" "proxy" {
  zone_id = "${aws_route53_zone.proxy.zone_id}"
  name    = "${var.domain}.${var.DnsZoneName}"
  type    = "A"
  ttl     = "300"
  records = ["${module.poxy.public_ip}"]
}
