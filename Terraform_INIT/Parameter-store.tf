resource "aws_ssm_parameter" "AKID" {
  name        = "AKID"
  description = "The parameter description"
  type        = "SecureString"
  value       = "UPDATE_ME"

}

resource "aws_ssm_parameter" "SAK" {
  name        = "SAK"
  description = "The parameter description"
  type        = "SecureString"
  value       = "UPDATE_ME"

}

resource "aws_ssm_parameter" "OUTPUT_BUCKET_NAME" {
  name        = "OUTPUT_BUCKET_NAME"
  description = "The parameter description"
  type        = "SecureString"
  value       = "dev-scrapy-output"

}