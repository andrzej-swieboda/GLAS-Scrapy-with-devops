FROM ubuntu:latest

#Place for project specific variables
#sounds great, doesn't work - check out Sources/CfgOutput-setup.sh

#ENV PROJECT_NAME MOTI_PROJECT
#ENV SPIDER_NAME motywatorka
#ENV SPIDER_FILE motywatorka_spider.py

#install dependencies

RUN apt-get update && \ 
    apt-get install --assume-yes --no-install-recommends \
    curl \
    nginx \
    unzip \
    apt-utils \
    python3 \
    python3-dev \
    python3-pip \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev \
    libffi-dev \
    libssl-dev

#install awscli

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install

#install main package

RUN pip install scrapy

#copy sources for the project

COPY Sources ./projects

#Initiate project and start crawlers

RUN chmod +x ./projects/cfg/Project-setup.sh
RUN chmod +x ./projects/cfg/Output-setup.sh
RUN ./projects/cfg/Project-setup.sh


#Data will be stored in json file inside the project dir.
