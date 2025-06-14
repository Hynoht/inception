#!/bin/bash

set -e

cd /var/www/html

rm -f index.html

if [ ! -f "adminer.php" ]; then
    wget https://github.com/vrana/adminer/releases/download/v5.3.0/adminer-5.3.0.php -O index.php > /dev/null
fi

exec php -S 0.0.0.0:8080 -t /var/www/html