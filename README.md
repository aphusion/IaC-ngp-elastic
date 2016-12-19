# IaC: IaC-ngp-elastic

This terraform script will setup an elk in AWS:
 - Private subnet
 - Public subnet
 - Nat gateway
 - Logstash server
 - Amazon Elasticsearch Service

#### Pre-requisites
- An IAM account with administrator privileges.
- Install [terraform](https://www.terraform.io/intro/getting-started/install.html) in your machine.

#### Steps for installation
- Clone this repo .
- Export AWS credentials as bash variables (e.g. `ap-northeast-1` for Tokyo and `ap-southeast-1` for Singapore region):
```
export AWS_ACCESS_KEY_ID="anaccesskey"
export AWS_SECRET_ACCESS_KEY="asecretkey"
export AWS_DEFAULT_REGION="ap-northeast-1"
```

Need not export the `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` in case you are using  IaC-manager.
- `cp terraform.dummy terraform.tfvars`
- `cat ~/terraform.out >> terraform.tfvars`.
- Modify params in `terraform.tfvars`
- Modify params in `variable.tf` to change subnet or add AMI accordingly to your aws region
- Run `terraform plan` to see the plan to execute.
- Run `terraform apply` to run the scripts.
- You may have `prod/dev/stage` configurations in
`terraform.tfvars.{prod/dev/stage}` files (already ignored by `.gitignore`).



#### Notes
- This script will output the the logstash elb URI where logstash server is running. while you are running filebeat
in your instances, configure it with the logstash elb URI with elb port as logstash URI.
`eg: internal-Logstash-xxx.ap-northeast-1.elb.amazonaws.com:80`


SSH into the manager node and check whether `terraform.out` in `home/centos` contains:
a record of the VPC and Internet gateway ID.
More details on [terraform-docs](https://github.com/segmentio/terraform-docs).

#### Contributing
please read through our guidelines for [Contributing](.github/CONTRIBUTING.md).