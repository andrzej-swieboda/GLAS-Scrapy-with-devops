#! /bin/bash

set -e

PROJECT_NAME=MOTI_PROJECT
SPIDER_FILE=motywatorka_spider.py

current_time=$(date "+%Y.%m.%d-%H.%M.%S")
spider_name=motywatorka

cd /projects/MOTI_PROJECT/spiders/

scrapy crawl motywatorka -o motywatorka-$current_time.json

cp /projects/MOTI_PROJECT/spiders/motywatorka-*.json /outputs

aws configure set aws_access_key_id $AKID
aws configure set aws_secret_access_key $SAK
aws configure set default.region us-east-1

aws s3 cp /outputs/ s3://$OUTPUT_BUCKET_NAME --grants read=uri=http://acs.amazonaws.com/groups/global/AllUsers --recursive
