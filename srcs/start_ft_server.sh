#!bin/bash

#Configuration Access
chown -R www-data /var/www/*
chmod -R 755 /var/www/*
# Create Website Folder
mkdir /var/www/localhost 

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

echo ""
echo "_______________    [ SETTING MYSQL ]    _______________"
echo ""
service mysql start
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
cd /tmp/
wget -c https://wordpress.org/latest.tar.gz
tar -xvzf latest.tar.gz
mv wordpress/ /var/www/localhost
mv /tmp/wp-config.php /var/www/localhost/wordpress

echo ""
echo "________________  [ SETTINGS COMPLETED ]  _______________"
echo ""

service php7.3-fpm start
service nginx restart

echo ""
echo "-------------------------------------------------------"
echo "---------------  WELCOME TO FT_SERVER  ----------------"
echo "---------------      By: Elian RC      ----------------"
echo "-------------------------------------------------------"
echo ""

echo "[ NGINX STATUS ]"
nginx -t
service nginx status
echo ""

echo "[ LINKS & COMMANDS ]"
echo "docker build -t ft_server ."
echo "docker run --name MYSERVER -it -p80:80 -p443:443 ft_server:lastest"
echo "https://localhost"

bash