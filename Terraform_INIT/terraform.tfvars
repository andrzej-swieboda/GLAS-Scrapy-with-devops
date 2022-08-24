region = "us-east-1"
dev_vpc_cidr = "10.0.0.0/24"
public_subnets = "10.0.0.128/26"
private_subnets = "10.0.0.192/26"
app_name = "scrapy"
app_env = "dev"
dev_image_tag = "DEV_SCRAPY_IMAGE"
caller_id = "data.aws_caller_identity.current.account_id"
dev_ecr_url = "repository_url"
task_name = "Deploy"