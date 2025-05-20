#!/bin/bash

set -e

cd /var/www/html

PATH_PLUGIN="/var/www/html/wp-content/plugins"

create_config() {
    local ADMIN_PASSWORD=$(cat /run/secrets/admin_password)
    local MYSQL_PASSWORD=$(cat /run/secrets/db_password)
    local USER_PASSWORD=$(cat /run/secrets/user_password)

    echo "Installation de WordPress..."

    wp config create \
        --allow-root \
        --dbname=$MYSQL_DATABASE \
        --dbuser=$MYSQL_USER \
        --dbpass=$MYSQL_PASSWORD \
        --dbhost=db --skip-check

    wp core  install \
        --allow-root \
        --url=$URL --title="$ADMIN_USER" \
        --admin_user="$ADMIN_USER" \
        --admin_password="$ADMIN_PASSWORD" \
        --admin_email=$ADMIN_EMAIL

    wp user create $SECOND_USER $USER_EMAIL \
        --user_pass=$USER_PASSWORD \
        --role=editor \
        --allow-root
}

install_plugin() {
    local REDIS_PASSWORD=$(cat /run/secrets/redis_password)
    echo "Install plugin redis-cache"
    wp plugin install redis-cache --activate --allow-root
    wp config set WP_REDIS_HOST 'redis' --type=constant --allow-root > /dev/null
    wp config set WP_REDIS_PORT 6379 --type=constant --allow-root > /dev/null
    wp config set WP_REDIS_PASSWORD "$REDIS_PASSWORD" --type=constant --allow-root > /dev/null
    wp config set WP_REDIS_CLIENT phpredis --type=constant --allow-root > /dev/null
    wp redis enable --allow-root || echo "Redis non disponible, activation ignorée"
    wp plugin auto-updates enable redis-cache --allow-root
}

wp core --allow-root download

if [ ! -f "wp-config.php" ]; then
    create_config
fi

find /var/www/html/ -type d -exec chmod 755 {} \;
find /var/www/html/ -type f -exec chmod 644 {} \;
chmod 640 /var/www/html/wp-config.php
chown -R www-data:www-data /var/www/html/


if [ ! -d "$PATH_PLUGIN/redis-cache" ]; then
    install_plugin
fi

if [ ! -f "adminer.php" ]; then
    wget https://github.com/vrana/adminer/releases/download/v5.3.0/adminer-5.3.0.php -O adminer.php > /dev/null
fi

exec php-fpm7.4 -F
