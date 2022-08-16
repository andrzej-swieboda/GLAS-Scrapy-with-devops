resource "aws_ecs_cluster" "ecs-dev" {
  name = "Dev-ecs-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_service" "scrapy-dev" {
    name = "scrapy-test-service"
    cluster = aws_ecs_cluster.ecs-dev.id
    desired_count = 1
}