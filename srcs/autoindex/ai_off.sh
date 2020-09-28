#!/bin/bash
#Simple script for autoindex automation
sed -i "s/autoindex on;/autoindex off;/g" /etc/nginx/sites-available/localhost
service nginx restart