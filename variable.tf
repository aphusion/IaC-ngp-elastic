variable "aws_region" {
  description = "EC2 Region for the VPC"
}

variable "key_pair_name" {
  description = "Name of AWS key pair to use with instances"
}

variable "vpc_id" {
  description = "VPC ID"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
}

variable "pre_tag" {
  description = "Pre-tag to be attached to AWS resources for identification"
}

variable "post_tag" {
  description = "Post-tag to be attached to AWS resources for identification"
}

variable "tag_service" {
  description = "Service tag"
}

variable "tag_environment" {
  description = "Environment tag"
}

variable "tag_version" {
  description = "Version tag"
}

variable "public_primary_subnet_cidr" {
  description = "CIDR for the Private Subnet"
  default = "10.0.1.0/24"
}

variable "public_secondary_subnet_cidr" {
  description = "CIDR for the Private Subnet"
  default = "10.0.2.0/24"
}

variable "private_primary_subnet_cidr" {
  description = "CIDR for the Private Subnet"
  default = "10.0.3.0/24"
}

variable "private_secondary_subnet_cidr" {
  description = "CIDR for the Private Subnet"
  default = "10.0.4.0/24"
}

variable "internet_gateway_id" {
  description = "Internet Gateway ID"
}


variable "coreos_amis" {
  description = "CoreOS AMIs used for logstash server"
  /* v1185.3.0, released 11/01/2016 */
  default = {
    ap-northeast-1 = "ami-99a30ef8"
    ap-southeast-1 = "ami-35ec4c56"
    ap-south-1 = "ami-d4a7d3bb"
  }
}

variable "logstash_instance_type" {
  description = "Logstash instance type"
  default = "m4.2xlarge"
}

variable "logstash_server_disk_size" {
  description = "The size of logstash node root block device disk in GB"
  default = "100"
}

variable "logstash_docker_image" {
  description = "Logstash docker image form public docker registry"
  default= "microservicestoday/logstash:2.0.9"
}

variable "es_instance_type" {
  description = "Elasticsearch instance type"
  default = "m3.large.elasticsearch"
}

variable "es_instance_count" {
  description = "Number of instances in the cluster"
  default = "1"
}

variable "es_ebs_enabled" {
  description = "Elasticsearch ebs volume enabled"
  default = true
}

variable "es_volume_type" {
  description = "Elasticsearch ebs volume type"
  default = "gp2"
}

variable "es_volume_size" {
  description = "Elasticsearch ebs volume size"
  default = 512
}

variable "es_dedicated_master_enabled" {
  description = "Indicates whether dedicated master nodes are enabled for the Elasticsearch cluster"
  default = true
}

variable "es_dedicated_master_type" {
  description = "Instance type of the dedicated master nodes in the Elasticsearch cluster."
  default = "m3.large.elasticsearch"
}

variable "es_dedicated_master_count" {
  description = "Number of dedicated master nodes in the Elasticsearch cluster"
  default = 3
}

variable "automated_snapshot_start_hour" {
  description = "Hour during which the elasticsearch service takes an automated daily snapshot of the indices in the domain."
  default = 23
}


variable "logstash_asg_max_size" {
  description = "The maximum size of the auto scale group."
  default = "5"
}

variable "logstash_asg_min_size" {
  description ="The minimum size of the auto scale group."
  default = "1"
}

variable "logstash_asg_desired_capacity" {
  description = "The number of Amazon EC2 instances that should be running in the group."
  default = "1"
}

variable "logstash_asg_health_check_grace_period" {
  description = "After instance comes into service before checking health."
  default = "300"
}

variable "logstash_asg_health_check_type" {
  description = "EC2 or ELB. Controls how health checking is done."
  default = "EC2"
}
