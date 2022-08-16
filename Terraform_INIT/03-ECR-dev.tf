resource "aws_ecr_repository" "dev-repository" {
    name    = "${var.app_name}-${var.app_env}-ecr"
    tags    = {
      Name    ="${var.app_name}-ecr"
      Environment = var.app_env
    }

    image_scanning_configuration {
      scan_on_push = true
    }
}