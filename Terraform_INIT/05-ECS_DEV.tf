resource "aws_ecs_cluster" "main" {
  name = "${var.app_name}-cluster-${var.app_env}"
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}



resource "aws_ecs_task_definition" "deploy-dev" {
  family                   = "Deploy"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 1024
  memory                   = 2048
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn
  container_definitions = <<TASK_DEFINITION
  [
    {
      "name"        :"${var.app_name}-container-${var.app_env}",
      "image"       : "${aws_ecr_repository.dev-repository.repository_url}:${var.dev_image_tag}",
      "command": [
          "/projects/cfg/Output-setup.sh"
        ],
      "workingDirectory": "/projects/cfg/",
      "secrets": [
          {
            "valueFrom": "${aws_ssm_parameter.AKID.arn}",
            "name": "AKID"
          },
          {
            "valueFrom": "${aws_ssm_parameter.SAK.arn}",
            "name": "SAK"
          },
          {
            "valueFrom": "${aws_ssm_parameter.OUTPUT_BUCKET_NAME.arn}",
            "name": "OUTPUT_BUCKET_NAME"
          }
        ],
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

#---------------------ROLE FOR TASK EXECUTION

# ECS task execution role data
data "aws_iam_policy_document" "ecs_task_execution_role" {
  version = "2012-10-17"
  statement {
    sid = ""
    effect = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

# ECS task execution role
resource "aws_iam_role" "ecs_task_execution_role" {
  name               = "dev_ecs_task_execution_role"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_role.json
}

# ECS task execution role policy attachment
resource "aws_iam_role_policy_attachment" "ecs_task_execution_role" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"

}

# ECS policy for parameter store

resource "aws_iam_policy" "policy" {
  name        = "test-policy"
  description = "A test policy"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "ssm:GetParameters",
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "parameter-store-att" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = aws_iam_policy.policy.arn
}


############-------cloudwatch rule for scheduling task



resource "aws_cloudwatch_event_rule" "event_rule" {
  name                = "Deploy"
  schedule_expression = "cron(0/5 * * * ? *)"
}

resource "aws_cloudwatch_event_target" "ecs_scheduled_task" {
  rule      = aws_cloudwatch_event_rule.event_rule.name
  target_id = "Deploy"
  arn       = aws_ecs_cluster.main.arn
  role_arn  = aws_iam_role.cloudwatch_role.arn                                 ###############################################################

  ecs_target {

    launch_type         = "FARGATE"
    platform_version    = "LATEST"
    task_count          = 1
    task_definition_arn = aws_ecs_task_definition.deploy-dev.arn                     ###############################################################
    network_configuration {
      subnets = var.subnet_ids
    }

  }

}
