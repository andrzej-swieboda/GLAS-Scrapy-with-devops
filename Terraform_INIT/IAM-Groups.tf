resource "aws_iam_group" "common_service" {

    name = "common_services"
}

resource "aws_iam_group" "developers" {
    name = "developers"
}

resource "aws_iam_group" "adiministrators" {
    name = "administrators"
}