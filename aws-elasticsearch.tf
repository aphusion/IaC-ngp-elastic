resource "aws_elasticsearch_domain" "elasticsearch" {
  domain_name = "${replace(lower(var.pre_tag), "/[^0-9a-z-]/","")}-${replace(lower(var.post_tag), "/[^0-9a-z-]/","")}"
  elasticsearch_version = "2.3"
  access_policies = "${data.template_file.elastic_access_policies.rendered}"
  cluster_config {
    instance_type = "${var.es_instance_type}"
    instance_count = "${var.es_instance_count}"
    dedicated_master_enabled = "${var.es_dedicated_master_enabled}"
    dedicated_master_type = "${var.es_dedicated_master_type}"
    dedicated_master_count = "${var.es_dedicated_master_count}"
  }

  ebs_options {
    ebs_enabled = "${var.es_ebs_enabled}"
    volume_type = "${var.es_volume_type}"
    volume_size = "${var.es_volume_size}"
  }

  snapshot_options {
    automated_snapshot_start_hour ="${var.automated_snapshot_start_hour}"
  }

  tags {
    Name = "${var.pre_tag}-ElasticSearch-${var.post_tag}"
    Service = "${var.tag_service}"
    Environment = "${var.tag_environment}"
    Version = "${var.tag_version}"
  }
}

data "template_file" "elastic_access_policies" {
  template = <<CONFIG
{
    "Statement": [
        {
            "Action": "es:*",
            "Condition": {
                "IpAddress": {"aws:SourceIp": ["$${aws_nat_gateway}"]}
            },
            "Effect": "Allow",
            "Principal": {
              "AWS": "*"
            },
            "Resource": "arn:aws:es:$${aws_region}:$${account_id}:domain/$${domain_name}/*"
        }
    ],
    "Version": "2012-10-17"
}
CONFIG

  vars {
    aws_nat_gateway = "${aws_nat_gateway.nat.public_ip}"
    aws_region = "${var.aws_region}"
    account_id = "${data.aws_caller_identity.current.account_id}"
    domain_name = "${replace(lower(var.pre_tag), "/[^0-9a-z-]/","")}-${replace(lower(var.post_tag), "/[^0-9a-z-]/","")}"
  }
}

data "aws_caller_identity" "current" { }
