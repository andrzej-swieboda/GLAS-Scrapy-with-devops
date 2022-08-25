# User created for the purpose of deployment

resource "aws_iam_user" "ECS-S3-sender" {
    name            = "ECS-S3-sender"
    path            = "/"
    force_destroy   = true
}

resource "aws_iam_user_policy_attachement" "attach_s3_policy" {
    user            = aws_iam_user.ECS-S3-sender.name
    policy_arn      = aws_iam_policy.s3_policy.arn
}

resource "aws_iam_access_key" "deploy-s3-agent" {
    user            = aws_iam_user.ECS-S3-sender.name
}