resource "aws_s3_bucket" "scrapy-output" {
  bucket = "${var.app_env}-scrapy-output"
}

#resource "aws_s3_bucket_versioning" "scrapy-output-versioning" {
#  bucket = aws_s3_bucket.scrapy-output.id
#  versioning_configuration {
#    status = "Enabled"
#  }
#}