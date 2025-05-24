FROM debian:bullseye

RUN apt update -y \
	&& apt install -y php-fpm php-mysql php-redis sendmail curl wget\
	&& curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp \
	&& rm -rf /var/lib/apt/lists/* \
	&& mkdir -p /run/php
	
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY ./tools/. /usr/bin

RUN chmod +x /usr/local/bin/wp && chmod +x /usr/bin/run.sh


ENTRYPOINT [ "/usr/bin/run.sh" ]
