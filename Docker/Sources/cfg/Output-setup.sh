#! /bin/bash

aws configure set aws_access_key_id $AKID
    aws configure set aws_secret_access_$SAK
        aws configure set default.region us-east-1

aws s3 cp /outputs/ s3://$BUCKET_NAME --grants read=uri=http://acs.amazonaws.com/groups/global/AllUsers --recursive
