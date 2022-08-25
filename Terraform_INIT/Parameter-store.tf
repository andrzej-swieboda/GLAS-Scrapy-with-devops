resource "aws_ssm_parameter" "AKID" {
  name        = "AKID"
  description = "The parameter description"
  type        = "SecureString"
  value       = aws_iam_access_key.deploy-s3-agent.id
  lifecycle {
    ignore_changes = [
      all,
    ]
  }

}

resource "aws_ssm_parameter" "SAK" {
  name        = "SAK"
  description = "The parameter description"
  type        = "SecureString"
  value       = aws_iam_access_key.deploy-s3-agent.secret
  lifecycle {
    ignore_changes = [
      all,
    ]
  }

}

resource "aws_ssm_parameter" "OUTPUT_BUCKET_NAME" {
  name        = "OUTPUT_BUCKET_NAME"
  description = "The parameter description"
  type        = "SecureString"
  value       = "dev-scrapy-output"
  lifecycle {
    ignore_changes = [
      all,
    ]
  }

}