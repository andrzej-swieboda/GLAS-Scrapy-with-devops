resource "aws_ecr_repository" "dev-repository" {
    name    ="dev_image_repository"

    image_scanning_configuration {
      scan_on_push = true
    }
}