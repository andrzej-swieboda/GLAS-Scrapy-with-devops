#! /bin/bash

#Set variable for project name
#only numbers, letters and underscores in names

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install

aws configure set aws_access_key_id AKIAUK3L6UMX44WQJHR7
        aws configure set aws_secret_access_key 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
        aws configure set default.region us-east-1

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

aws configure set aws_access_key_id AKIA4DZDFY3YTVYMCHUZ
        aws configure set aws_secret_access_key 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
        aws configure set default.region us-east-1

aws s3 cp /outputs/ s3://scrapy-dev-backends --recursive


