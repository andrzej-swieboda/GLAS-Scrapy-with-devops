resource "aws_s3_bucket" "dev-scrapy-output" {
  bucket = "dev-spider-output"
}

resource "aws_s3_bucket_acl" "dev-scrapy-output" {
  bucket = aws_s3_bucket.dev-scrapy-output.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "dev-scrapy-output-versioning" {
  bucket = aws_s3_bucket.dev-scrapy-output.id
  versioning_configuration {
    status = "Enabled"
  }
}