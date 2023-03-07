#!/bin/bash
# This startup script has been made following the official guidelines of Ubuntu.
# https://ubuntu.com/tutorials/install-and-configure-wordpress#1-overview

################################################
#####   Installation of Apache Web Server  #####
################################################
sudo apt install apache2
sudo systemctl start apache2
sudo apt install ghostscript \
                 libapache2-mod-php \
                 mysql-server \
                 php \
                 php-bcmath \
                 php-curl \
                 php-imagick \
                 php-intl \
                 php-json \
                 php-mbstring \
                 php-mysql \
                 php-xml \
                 php-zip


#####   Creation and Configuration of the Directory for WordPress  #####
sudo mkdir -p /srv/www
sudo chown www-data: /srv/www
curl https://wordpress.org/latest.tar.gz | sudo -u www-data tar zx -C /srv/www #Download the latest version of WP into the /srv/www directory

#####   Update WordPress config file  #####
echo "<VirtualHost *:80>
    DocumentRoot /srv/www/wordpress
    <Directory /srv/www/wordpress>
        Options FollowSymLinks
        AllowOverride Limit Options FileInfo
        DirectoryIndex index.php
        Require all granted
    </Directory>
    <Directory /srv/www/wordpress/wp-content>
        Options FollowSymLinks
        Require all granted
    </Directory>
</VirtualHost>" | sudo tee -a /etc/apache2/sites-available/wordpress.conf

#####   Update hosts file  #####
echo "<VirtualHost *:80>
    ServerName hostname.example.com
    ... # the rest of the VHost configuration
</VirtualHost>" | sudo tee -a /etc/hosts

sudo service apache2 reload

##### Enable MySQL DBMS #####

sudo systemctl enable mysql
sudo systemctl start mysql

sudo /usr/bin/mysql -e "CREATE DATABASE wordpress;"
sudo /usr/bin/mysql -e "CREATE USER wordpress@localhost IDENTIFIED BY '<your-password>';"

##### Install other PHP packages #####

sudo apt -y install php-bz2 php-mysqli php-gd php-common
sudo systemctl restart apache2 

##### Copy the config file into WP config file  #####
sudo -u www-data cp /srv/www/wordpress/wp-config-sample.php /srv/www/wordpress/wp-config.php
##### Configure username and password  #####
sudo -u www-data sed -i 's/admin/wordpress/' /srv/www/wordpress/wp-config.php
sudo -u www-data sed -i 's/new_password/<your-password>/' /srv/www/wordpress/wp-config.php
