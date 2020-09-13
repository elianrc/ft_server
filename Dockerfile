# Container OS
FROM debian:buster
RUN apt-get update && \
    apt-get -y install apt-utils && \
    apt-get upgrade && \
    apt-get -y install vim openssl curl

LABEL maintainer="Elian RC <erc@student.42.us.org>"

# Install php
RUN apt-get -y install php

# Install Nginx
RUN apt-get -y install nginx

# Install MariaDB (MySQL)
RUN apt-get -y install default-mysql-server

# # Install phpMyAdmin
# RUN apt-get -y install phpmyadmin

# Install WordPress
RUN apt-get -y install wordpress

EXPOSE 88
