#! /bin/bash

#Set variable for project name
#only numbers, letters and underscores in names


set -e
PROJECT_NAME=MOTI_PROJECT
SPIDER_NAME=motywatorka
SPIDER_FILE=motywatorka_spider.py

scrapy startproject $PROJECT_NAME ../projects
cp ./projects/$SPIDER_FILE ./projects/$PROJECT_NAME/spiders

echo "Script Completed with project name $PROJECT_NAME"

cd ./projects/$PROJECT_NAME/spiders
scrapy crawl $SPIDER_NAME

echo "Spider crawled"


