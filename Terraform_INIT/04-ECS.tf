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
container_definitions = <<TASK_DEFINITION
[
  {
    "cpu": 10,
    "command": ["sleep", "10"],
    "entryPoint": ["/"],
    "environment": [
      {"name": "VARNAME", "value": "VARVAL"}
    ],
    "essential": true,
    "image": "jenkins",
    "memory": 128,
    "name": "jenkins",
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 8080
      }
    ],
        "resourceRequirements":[
            {
                "type":"InferenceAccelerator",
                "value":"device_1"
            }
        ]
  }
]
TASK_DEFINITION

  inference_accelerator {
    device_name = "device_1"
    device_type = "eia1.medium"
  }
}
