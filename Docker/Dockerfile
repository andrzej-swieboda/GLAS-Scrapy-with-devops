FROM ubuntu:latest

#install dependencies

RUN apt-get update && \ 
    apt-get install --assume-yes --no-install-recommends \
    apt-utils \
    python3 \
    python3-dev \
    python3-pip \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev \
    libffi-dev \
    libssl-dev

#install main package

RUN pip install scrapy

#copy sources for the project

COPY Sources ./projects
COPY Spiders ./projects

#Initiate project and start crawlers

RUN chmod +x ./projects/cfg/Project-setup.sh
RUN ./projects/cfg/Project-setup.sh

#Data will be stored in json file inside the project dir.
