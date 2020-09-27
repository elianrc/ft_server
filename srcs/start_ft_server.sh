#!bin/bash

echo ""
echo "-------------------------------------------------------"
echo "---------------  WELCOME TO FT_SERVER  ----------------"
echo "---------------      By: Elian RC      ----------------"
echo "-------------------------------------------------------"
echo ""

#Configuration Access
chown -R www-data /var/www/*
chmod -R 755 /var/www/*

# Create Website Folder
mkdir /var/www/localhost && touch /var/www/localhost/index.php
echo "<?php phpinfo(); ?>" >> /var/www/localhost/index.php

# Start MySQL
service mysql start

echo ""
echo "_______________   [ SETTING SSL KEY ]   _______________"
echo ""
mkdir /etc/nginx/ssl
openssl req -newkey rsa:4096 -x509 -sha256 -days 3650 -nodes -out /etc/nginx/ssl/localhost.pem -keyout /etc/nginx/ssl/localhost.key -subj "/C=CA/ST=California/L=Fremont/O=42 Sillicon Valley/OU=erc/CN=ft_server"

echo ""
echo "_______________    [ SETTING NGINX ]    _______________"
echo ""
mv /tmp/nginx.conf /etc/nginx/sites-available/localhost
ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/localhost
rm -rf /etc/nginx/sites-enabled/default
nginx -t

echo ""
echo "_______________    [ SETTING MYSQL ]    _______________"
echo ""
mysql -u root --skip-password << EOF
CREATE DATABASE wordpress_db;
GRANT ALL ON wordpress_db.* TO 'root'@'localhost' IDENTIFIED BY 'password';
FLUSH PRIVILEGES;
EOF

echo ""
echo "_______________  [ SETTING PHPMYADMIN ]  _______________"
echo ""
mkdir /var/www/localhost/phpmyadmin
wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
tar -xvf phpMyAdmin-4.9.0.1-all-languages.tar.gz --strip-components 1 -C /var/www/localhost/phpmyadmin
mv /tmp/phpmyadmin.inc.php /var/www/localhost/phpmyadmin/config.inc.php

echo ""
echo "________________  [ SETTING WORDPRESS ]  _______________"
echo ""
apt install -y php7.3-common php7.3-gmp php7.3-curl php7.3-intl php7.3-mbstring php7.3-xmlrpc php7.3-gd php7.3-xml php7.3-cli php7.3-zip php7.3-soap php7.3-imap
cd /tmp/
wget -c https://wordpress.org/latest.tar.gz
tar -xvzf latest.tar.gz
mv wordpress/ /var/www/localhost
mv /tmp/wp-config.php /var/www/localhost/wordpress

echo ""
echo "_________________________________________________________"
echo ""

service php7.3-fpm start
service nginx restart