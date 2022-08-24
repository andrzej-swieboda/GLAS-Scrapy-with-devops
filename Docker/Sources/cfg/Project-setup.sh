#! /bin/bash

#Set variable for project name
#only numbers, letters and underscores in names



set -e
PROJECT_NAME=MOTI_PROJECT
SPIDER_NAME=motywatorka
SPIDER_FILE=motywatorka_spider.py

current_time=$(date "+%Y.%m.%d-%H.%M.%S")

scrapy startproject $PROJECT_NAME ../projects
cp ./projects/$SPIDER_FILE ./projects/$PROJECT_NAME/spiders

cd ./projects/$PROJECT_NAME/spiders/

echo "Script Completed with project name $PROJECT_NAME"
echo "Initiating spider crawl"

scrapy crawl $SPIDER_NAME

