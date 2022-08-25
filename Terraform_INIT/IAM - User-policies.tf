resource "aws_iam_policy" "s3_policy" {
    name        = "s3_policy"
    description = "Allow all s3 actions"
    policy  = jsonencode({
        Version = "2012-10-17"
        Statement = [
        {
            Action = [
              "s3:*",
            ]
            Effect   = "Allow"
            Resource = "*"
        },
        ]
    })
}