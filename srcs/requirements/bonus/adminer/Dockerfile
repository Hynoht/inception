FROM debian:bullseye

RUN apt update && apt install -y \
	php \
	php-mysqli \
	wget \
	&& rm -rf /var/lib/apt/lists/*

COPY ./tools/run.sh /usr/bin/run.sh

RUN chmod +x /usr/bin/run.sh

CMD ["/usr/bin/run.sh"]
