#! /bin/bash

#! /bin/bash

echo "Initiating spider crawl"

current_time=$(date "+%Y.%m.%d-%H.%M.%S")

cd ./projects/$PROJECT_NAME/spiders/

scrapy crawl $SPIDER_NAME -o $SPIDER_NAME$current_time.json

cp ./$SPIDER_NAME*.json /outputs

echo "Copying to storage"

aws configure set aws_access_key_id $AKID
    aws configure set aws_secret_access_key $SAK
        aws configure set default.region us-east-1

aws s3 cp /outputs/$SPIDER_NAME$current_time.json s3://$OUTPUT_BUCKET_NAME --grants read=uri=http://acs.amazonaws.com/groups/global/AllUsers --recursive
