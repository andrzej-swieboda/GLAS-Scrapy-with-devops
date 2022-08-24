data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

resource "aws_iam_role" "cloudwatch_role" {
  name               = "Deploy-cloudwatch-execution"
  assume_role_policy = <<EOF
  {
  "Version": "2012-10-17",
      "Statement": [
          {
              "Effect": "Allow",
              "Action": [
                  "ecs:RunTask"
              ],
              "Resource": [
                  "*"
              ]
          },
          {
              "Effect": "Allow",
              "Action": "iam:PassRole",
              "Resource": [
                  "*"
              ],
              "Condition": {
                  "StringLike": {
                      "iam:PassedToService": "ecs-tasks.amazonaws.com"
                  }
              }
          }
      ]
  }
  EOF
}

  resource "aws_iam_role_policy_attachment" "cloudwatch" {
  role       = aws_iam_role.cloudwatch_role.name
  policy_arn = aws_iam_policy.cloudwatch.arn
}

resource "aws_iam_policy" "cloudwatch" {
  name   = "Deploy-cloudwatch-execution"
  policy = data.aws_iam_policy_document.cloudwatch.json
}

data "aws_iam_policy_document" "task_execution_assume_role" {
  statement {
    principals {
      type = "Service"
      identifiers = [
        "ecs-tasks.amazonaws.com"
      ]
    }
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
  }
}

data "aws_iam_policy_document" "task_execution_cloudwatch_access" {
  statement {
    effect = "Allow"
    actions = [
      "logs:PutRetentionPolicy",
      "logs:CreateLogGroup"
    ]
    resources = ["arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:${var.task_name}:*"]
  }
}

locals {
  ecs_task_execution_role_arn  = aws_iam_role.ecs_task_execution_role.arn
  ecs_task_execution_role_name = aws_iam_role.ecs_task_execution_role.name
}


resource "aws_iam_role" "task_execution_role" {
  count = aws_iam_role.ecs_task_execution_role.name == "" ? 1 : 0

  name               = "${var.task_name}-execution"
  assume_role_policy = data.aws_iam_policy_document.task_execution_assume_role.json
}

resource "aws_iam_policy" "task_execution_logging_policy" {
  name   = "${var.task_name}-logging"
  policy = data.aws_iam_policy_document.task_execution_cloudwatch_access.json
}

// Cloudwatch execution role


data "aws_iam_policy_document" "cloudwatch" {
    statement {
    effect    = "Allow"
    actions   = ["ecs:RunTask"]
    resources = [aws_ecs_task_definition.deploy-dev.arn]
  }
  statement {
    effect  = "Allow"
    actions = ["iam:PassRole"]
    resources = concat([
      local.ecs_task_execution_role_arn
    ], var.task_role_arn != null ? [var.task_role_arn] : [])   ##########??????
  }
}