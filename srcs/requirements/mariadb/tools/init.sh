#!/bin/bash

set -e

MYSQL_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
MYSQL_PASSWORD=$(cat /run/secrets/db_password)

if [ ! -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then

    mysql_install_db --user=mysql > /dev/null

    mysqld_safe --skip-networking &
    until mysqladmin ping --silent; do
        echo "⏳ En attente de MariaDB..."
        sleep 2
    done

    mysql -u root -p"$MYSQL_ROOT_PASSWORD" <<EOF
    CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\`;
    USE \`$MYSQL_DATABASE\`;

    CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
    GRANT ALL PRIVILEGES ON \`$MYSQL_DATABASE\`.* TO '$MYSQL_USER'@'%';
    FLUSH PRIVILEGES;
EOF

    mysqladmin shutdown
fi

exec mysqld
