#!/bin/bash

set -e

rm -rf /var/www/html/phpmyadmin/*
mkdir -p /var/www/html/phpmyadmin && mkdir -p /run/php
if [ -d /usr/share/phpmyadmin ]; then
	cp -r /usr/share/phpmyadmin/* /var/www/html/phpmyadmin/
fi

if [ -f ./config.inc.php ]; then
    cp ./config.inc.php /var/www/html/phpmyadmin/
fi

find /var/www/html/ -type d -exec chmod 755 {} \;
find /var/www/html/ -type f -exec chmod 644 {} \;

chown -R www-data:www-data /var/www/html

exec php-fpm7.4 -F
