#! /bin/bash

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install

aws configure set aws_access_key_id AKIAUK3L6UMX44WQJHR7
        aws configure set aws_secret_access_key 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
        aws configure set default.region us-east-1


aws s3 cp /outputs/motywatorka.json s3://glas-scrapybackend-dev --grants read=uri=http://acs.amazonaws.com/groups/global/AllUsers --recursive