output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "repository_url" {
  description = "The URL of the repository."
  value = aws_ecr_repository.dev-repository.repository_url
}