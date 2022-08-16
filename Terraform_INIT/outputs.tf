output "ecr_repository_worker_endpoint" {
    value = aws_ecr_repository.worker.repository_url
}