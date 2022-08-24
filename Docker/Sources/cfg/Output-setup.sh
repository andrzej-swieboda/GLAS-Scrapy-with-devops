#! /bin/bash

set -e

current_time=$(date "+%Y.%m.%d-%H.%M.%S")
spider_name=motywatorka
poject_name=MOTI_PROJECT

cd /projects/$project_name/spiders/

scrapy crawl $spider_name -o $spider_name-$current_time.json

cp /projects/MOTI_PROJECT/spiders/*.json /outputs

aws configure set aws_access_key_id $AKID
aws configure set aws_secret_access_key $SAK
aws configure set default.region us-east-1

aws s3 cp /outputs/ s3://$OUTPUT_BUCKET_NAME --grants read=uri=http://acs.amazonaws.com/groups/global/AllUsers --recursive
