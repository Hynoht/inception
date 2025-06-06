FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    wget \
    unzip \
	php-fpm \
	php-mysql \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.2.1/phpMyAdmin-5.2.1-all-languages.zip -O /tmp/pma.zip && \
    unzip /tmp/pma.zip -d /usr/share/ && \
    mv /usr/share/phpMyAdmin-5.2.1-all-languages /usr/share/phpmyadmin && \
    rm /tmp/pma.zip

COPY ./conf/run.sh  ./run.sh
COPY ./conf/config.inc.php  ./config.inc.php
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY ./conf/php-fpm.conf /etc/php/7.4/fpm/php-fpm.conf

RUN	chmod +x ./run.sh

CMD ["./run.sh"]