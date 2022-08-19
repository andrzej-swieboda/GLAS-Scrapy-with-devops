#! /bin/bash

#Set variable for project name
#only numbers, letters and underscores in names



set -e
PROJECT_NAME=MOTI_PROJECT
SPIDER_NAME=motywatorka
SPIDER_FILE=motywatorka_spider.py

mkdir output

scrapy startproject $PROJECT_NAME ../projects
cp ./projects/$SPIDER_FILE ./projects/$PROJECT_NAME/spiders

cd ./projects/$PROJECT_NAME/spiders/

echo "Script Completed with project name $PROJECT_NAME"
echo "Initiating spider crawl"

scrapy crawl $SPIDER_NAME -o $SPIDER_NAME.json

cp ./$SPIDER_NAME.json /outputs

#aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
#        aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
#        aws configure set default.region us-east-1

#aws s3 cp ./$SPIDER_NAME.json s3://glas-scrapybackend-dev --recursive

