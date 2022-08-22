resource "aws_s3_bucket" "dev-scrapy-output" {
  bucket = "dev-scrapy-output"
}

resource "aws_s3_bucket_versioning" "dev-scrapy-output-verioning" {
  bucket = aws_s3_bucket.dev-scrapy-output.id
  versioning_configuration {
    status = "Enabled"
  }
}