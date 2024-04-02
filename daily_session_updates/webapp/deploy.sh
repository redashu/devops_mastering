#!/bin/bash

if [ "$app" == "dev" ]
then
    cp -rf /webapp/app1/*  /var/www/html/
    httpd -DFOREGROUND 
elif [ "$app" == "prod" ]
then
    cp -rf /webapp/app2/*  /var/www/html/
    httpd -DFOREGROUND
else 
    echo "please provide correct value like prod or dev" >/var/www/html/index.html
    httpd -DFOREGROUND
fi 