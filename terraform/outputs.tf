output "alb_dns_name" {
  value = "${aws_lb.proxy_alb.dns_name}"
}

output "proxy_ip" {
  value = "${module.poxy.public_ip}"
}

output "vpc_cidr_blocks" {
  value = "${var.vpc_cidr_blocks}"
}

output "ElasticSearch Endpoint" {
  value = "${aws_elasticsearch_domain.es.endpoint}"
}

output "ElasticSearch Kibana Endpoint" {
  value = "${aws_elasticsearch_domain.es.kibana_endpoint}"
}
