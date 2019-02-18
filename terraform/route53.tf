resource "aws_route53_zone" "proxy" {
  name = "${var.DnsZoneName}"

  tags {
    Name = "proxy"
  }
}
