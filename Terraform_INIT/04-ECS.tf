resource "aws_ecs_cluster" "ecs-dev" {
  name = "Dev-ecs-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_service" "scrapy-dev" {
    name            = "scrapy-test-service"
    cluster         = aws_ecs_cluster.ecs-dev.id
    task_definition = aws_ecs_task_definition.service.arn
    desired_count   = 1
}

resource "aws_ecs_task_definition" "service" {
    family  = "service"
    container_definitions = file("task_definitions/service.json")
    

}