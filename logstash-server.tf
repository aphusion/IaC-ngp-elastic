resource "aws_autoscaling_group" "logstash_asg" {
  name = "${var.pre_tag}-Logstash-AS-group-${var.post_tag}"

  max_size = "${var.logstash_asg_max_size}"
  min_size = "${var.logstash_asg_min_size}"
  desired_capacity = "${var.logstash_asg_desired_capacity}"

  health_check_type = "${var.logstash_asg_health_check_type}"
  health_check_grace_period = "${var.logstash_asg_health_check_grace_period}"

  launch_configuration = "${aws_launch_configuration.logstash_lc.name}"

  vpc_zone_identifier = [
    "${aws_subnet.private-primary.id},${aws_subnet.private-secondary.id}"]

  load_balancers = ["${aws_elb.logstash.id}"]

  force_delete = true

  tag {
    key = "Name"
    value = "${var.pre_tag}-Logstash-Server-${var.post_tag}"
    propagate_at_launch = true
  }
}

resource "aws_launch_configuration" "logstash_lc" {
  name_prefix = "${var.pre_tag}-Logstash-AS-LC-"
  image_id = "${lookup(var.coreos_amis, var.aws_region)}"
  instance_type = "${var.logstash_instance_type}"
  key_name = "${var.key_pair_name}"
  security_groups = ["${aws_security_group.private.id}"]
  user_data = "${data.template_file.logstash_server_user_data.rendered}"

  root_block_device {
    volume_size = "${var.logstash_server_disk_size}"
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

data "template_file" "logstash_server_user_data" {
  template = "${file(format("%s/user-data/logstash-server-cloud-config.yaml.tpl", path.module))}"

  vars {
    logstash_image = "${var.logstash_docker_image}"
    elasticsearch_uri = "${aws_elasticsearch_domain.elasticsearch.endpoint}:443"
    dcos_name = "${var.pre_tag}-${var.post_tag}"
  }
}