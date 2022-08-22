resource "aws_s3_bucket" "output-storage" {
  bucket = "output-storage"
  acl    = "private"

  versioning {
    enabled = true
  }
}