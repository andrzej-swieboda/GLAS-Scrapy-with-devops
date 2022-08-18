FROM ubuntu:latest

#install dependencies

RUN apt-get update && \ 
    apt-get install --assume-yes --no-install-recommends \
    nginx \
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
RUN mkdir outputs

#copy sources for the project

COPY Sources ./projects

#Initiate project and start crawlers

RUN chmod +x ./projects/cfg/Project-setup.sh
RUN ./projects/cfg/Project-setup.sh

#Data will be stored in json file inside the project dir.

RUN mkdir /var/www/status_page
RUN cp ./projects/index.html /var/www/status_page
RUN cp ./projects/status_page /etc/nginx/sites-enabled

EXPOSE 81
EXPOSE 8181
EXPOSE 80

ENTRYPOINT [ "service nginx restart" ]
