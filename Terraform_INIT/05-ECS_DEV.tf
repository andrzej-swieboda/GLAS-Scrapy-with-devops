resource "aws_ecs_cluster" "main" {
  name = "${var.app_name}-cluster-${var.app_env}"
}



resource "aws_ecs_task_definition" "deploy" {
  family                   = "test"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 1024
  memory                   = 2048
  #execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  #task_role_arn            = aws_iam_role.ecs_task_role.arn
  container_definitions = <<TASK_DEFINITION
  [
    {
      "name"        :"${var.app_name}-container-${var.app_env}",
      "image"       : "693798433817.dkr.ecr.${var.region}.amazonaws.com/${var.app_name}-${var.app_env}-ecr:${var.dev_image_tag}",
      "essential"   : true,
      "cpu"         : 1024,
      "memory"      : 1024
    }
  ]
  TASK_DEFINITION
  }


resource "aws_iam_role" "ecs_task_role" {
  name = "${var.app_name}-ecsTaskRole"
 
  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "ecs-tasks.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}