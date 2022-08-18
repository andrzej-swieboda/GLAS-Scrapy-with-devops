#! /bin/bash

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install

aws configure

#AWS Access Key ID [None]: 
AKIAUK3L6UMX44WQJHR7
#AWS Secret Access Key [None]: 
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
#Default region name [None]: 
us-east-1
#Default output format [None]: 
ENTER

aws s3 cp /outputs/motywatorka.json s3://glas-scrapybackend-dev --grants read=uri=http://acs.amazonaws.com/groups/global/AllUsers --recursive