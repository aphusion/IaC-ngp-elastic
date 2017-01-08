## NGP Elastic - Elastic Stack module

### Components
1. Logstash 5.1.1
2. Elasticsearch 5.1.1
3. Kibana 5.1.1

### Pre-requisites
- AWS IAM Account.
- Key Pair to access EC2 instances.
- VPC with public and private subnets
    - (Optional) Use IaC-NGP-AWS to create the infrastructure to set up ELastic Stack. This includes VPC, Public and Private Subnets in multiple availability zones.
- Hosted Zone in AWS Route53 for your Domain. This is required to create a record for creating a friendly dns name for Logstash and Kibana Loadbalancers.
- "Accept Software Terms" of AWS Marketplace for CentOS if required.

### Steps
- clone this repo.
- Go to AWS CloudFormation UI and select "Create Stack".
- Choose the 'elastic.yaml' file from the cloned repo in "Choose file" under "Choose a template" in "Select Template" section.
- Provide the requested pameters.
