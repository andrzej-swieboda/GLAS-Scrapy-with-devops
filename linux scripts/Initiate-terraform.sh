#! /bin/bash
set -e
export AWS_ACCESS_KEY_ID=${{ secrets.AWS_ACCESS_KEY_ID }}
export AWS_SECRET_ACCESS_KEY=${{ secrets.AWS_SECRET_ACCESS_KEY }}
export AWS_REGION="us-east-1"
terraform init - reconfigure -upgrade
terraform validate
terraform plan
terraform apply -auto-approve