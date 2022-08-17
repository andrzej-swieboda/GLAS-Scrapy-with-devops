#! /bin/bash

mkdir /var/www/status_page
cp ./projects/index.html /var/www/status_page
cp ./projects/status_page /etc/nginx/sites-enabled

service nginx restart
