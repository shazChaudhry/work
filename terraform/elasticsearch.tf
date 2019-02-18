locals {
  es_domain = "elasticsearch"
}

resource "aws_security_group" "es_sg" {
  name        = "${local.es_domain}-sg"
  description = "Allow inbound traffic to ElasticSearch from VPC CIDR"
  vpc_id      = "${module.vpc.vpc_id}"
}

resource "aws_security_group_rule" "allow_http" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  # cidr_blocks       = ["${var.vpc_cidr_blocks}"]
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.es_sg.id}"
}

resource "aws_iam_service_linked_role" "es" {
  aws_service_name = "es.amazonaws.com"
  description      = "es.amazonaws.com - service linked role for elasticsearch"
}

resource "aws_elasticsearch_domain" "es" {
  domain_name           = "${local.es_domain}"
  elasticsearch_version = "6.4"

  cluster_config {
    instance_type = "${var.instance_type}"
    # instance_count = "${var.instance_count}"
  }

  ebs_options {
    ebs_enabled = true
    volume_size = "${var.disk_size_gb}"
  }

  vpc_options {
    subnet_ids         = ["${module.vpc.public_subnets[0]}"]
    security_group_ids = ["${aws_security_group.es_sg.id}"]
  }

  depends_on = ["aws_iam_service_linked_role.es"]
}
