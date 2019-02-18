# resource "aws_acm_certificate" "proxy_cert" {
#   domain_name       = "${var.domain}.${var.DnsZoneName}"
#   validation_method = "DNS"
#
#   tags = {
#     # Name = "Proxy"
#     Environment = "dev"
#   }
#
#   lifecycle {
#     create_before_destroy = true
#   }
# }
#
# resource "aws_route53_record" "proxy_cert_dns" {
#     zone_id = "${aws_route53_zone.elasticsearch.zone_id}"
#     name = "${aws_acm_certificate.proxy_cert.domain_validation_options.0.resource_record_name}"
#     type = "${aws_acm_certificate.proxy_cert.domain_validation_options.0.resource_record_type}"
#     ttl = 60
#
#     records = [ "${aws_acm_certificate.proxy_cert.domain_validation_options.0.resource_record_value}"]
# }
#
# resource "aws_acm_certificate_validation" "proxy_cert_validation" {
#   certificate_arn         = "${aws_acm_certificate.proxy_cert.arn}"
#   validation_record_fqdns = ["${aws_route53_record.proxy_cert_dns.fqdn}"]
# }

