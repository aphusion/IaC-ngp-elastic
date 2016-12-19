resource "aws_elb" "logstash" {
  name            = "${null_resource.alias.triggers.lb_pre_tag}-Logstash-${null_resource.alias.triggers.lb_post_tag}"
  subnets         = ["${aws_subnet.private-primary.id}","${aws_subnet.private-secondary.id}"]
  security_groups = ["${aws_security_group.public.id}"]
  internal        = true

  "listener" {
    instance_port      = 5044
    instance_protocol  = "tcp"
    lb_port            = 80
    lb_protocol        = "tcp"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout  = 5
    target   = "TCP:22"
    interval = 30
  }

  provisioner "local-exec" {
    command = "echo 'elb_logstash_id=\"${self.id}\"' >> ../terraform.out"
  }
}

resource "null_resource" "alias" {
  triggers = {
    lb_pre_tag = "${replace(replace(var.pre_tag, "/[^0-9a-zA-Z-]/",""), "/^(.{14}).*/","$1")}"
    lb_post_tag = "${replace(replace(var.post_tag, "/[^0-9a-zA-Z-]/",""), "/^(.{6}).*/","$1")}"
  }
}
