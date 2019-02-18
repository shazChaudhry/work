resource "aws_lb" "proxy_alb" {
  name               = "proxy-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.proxy_alb_sg.id}"]
  subnets            = ["${module.vpc.public_subnets}"]

  tags = {
    Environment = "dev"
    Name        = "${var.domain}"
  }
}

resource "aws_lb_listener" "proxy_alb_listener" {
  load_balancer_arn = "${aws_lb.proxy_alb.arn}"
  port              = "80"
  protocol          = "HTTP"

  # port              = "443"
  # protocol          = "HTTPS"
  # ssl_policy        = "ELBSecurityPolicy-2016-08"
  # certificate_arn   = "${aws_acm_certificate_validation.cert_validation.certificate_arn}"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.proxy_lb_tg.arn}"
  }
}

resource "aws_lb_target_group" "proxy_lb_tg" {
  name     = "proxy-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${module.vpc.vpc_id}"
}

resource "aws_lb_target_group_attachment" "proxy_attachment" {
  target_group_arn = "${aws_lb_target_group.proxy_lb_tg.arn}"
  target_id        = "${module.poxy.id[0]}"
  port             = 80
}
