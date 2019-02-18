resource "aws_security_group" "proxy_alb_sg" {
  name   = "proxy-alb-sg"
  vpc_id = "${module.vpc.vpc_id}"
}

resource "aws_security_group_rule" "allow_alb_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.proxy_alb_sg.id}"
}

resource "aws_security_group_rule" "allow_alb_egress_to_proxy" {
  type                     = "egress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.proxy_alb_sg.id}"
  source_security_group_id = "${aws_security_group.proxy_sg.id}"
}

resource "aws_security_group" "proxy_sg" {
  name   = "proxy-sg"
  vpc_id = "${module.vpc.vpc_id}"
}

resource "aws_security_group_rule" "allow_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.proxy_sg.id}"
}

resource "aws_security_group_rule" "allow_http_from_alb" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.proxy_sg.id}"
  source_security_group_id = "${aws_security_group.proxy_alb_sg.id}"
}

resource "aws_security_group_rule" "allow_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.proxy_sg.id}"
}
