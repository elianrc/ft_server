# Container OS
FROM debian:buster

LABEL maintainer="Elian RC <erc@student.42.us.org>"

RUN apt-get update && apt-get -y install apt-utils vim wget openssl
# Install php
RUN apt-get -y install php7.3-fpm php7.3-mysql
# Install Nginx
RUN apt-get install nginx -y 
# Install MariaDB (MySQL)
RUN apt-get install mariadb-server -y

EXPOSE 80 443

COPY srcs /tmp/

# CMD bash /tmp/start_ft_server.sh

# php7.3-common php7.3-gmp php7.3-curl php7.3-intl php7.3-mbstring php7.3-xmlrpc php7.3-gd php7.3-xml php7.3-cli php7.3-zip php7.3-soap php7.3-imap