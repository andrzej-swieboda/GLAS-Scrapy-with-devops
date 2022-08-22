resource "aws_s3_bucket" "output-storage" {
  bucket = "dev-spider-output"
}

resource "aws_s3_bucket_acl" "output-storage" {
  bucket = aws_s3_bucket.output-storage.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "output-versioning" {
  bucket = aws_s3_bucket.output-storage.id
  versioning_configuration {
    status = "Enabled"
  }
}