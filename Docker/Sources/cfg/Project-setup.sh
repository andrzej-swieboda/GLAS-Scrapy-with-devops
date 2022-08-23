#! /bin/bash


scrapy startproject $PROJECT_NAME ../projects
mv ./projects/$SPIDER_FILE ./projects/$PROJECT_NAME/spiders


echo "Script Completed with project name $PROJECT_NAME"




