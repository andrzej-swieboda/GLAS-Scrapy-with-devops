variable "app_env" {}
variable "region" {}
variable "dev_vpc_cidr" {}
variable "public_subnets" {}
variable "private_subnets" {}
variable "app_name" {}
variable "app_env" {}
variable "dev_image_tag" {}
variable "caller_id" {}
variable "dev_ecr_url" {}
variable "task_name" {}

variable "task_role_arn" {
  default     = null
  description = "IAM role ARN for your task if it needs to access any AWS resources.  IMPORTANT: This must have an AssumeRolePolicy that includes the 'ecs-tasks.amazonaws.com' provider!!"
}