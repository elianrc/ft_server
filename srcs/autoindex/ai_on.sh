#!/bin/bash
#Simple script for autoindex on/off automation
sed -i "s/autoindex off;/autoindex on;/g" /etc/nginx/sites-available/localhost
service nginx restart