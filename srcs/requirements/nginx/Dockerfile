FROM debian:bullseye

RUN apt update -y \
	&& apt install -y nginx openssl \
	&& rm -rf /var/lib/apt/lists/* \
	&& rm /etc/nginx/sites-enabled/default

RUN mkdir -p /etc/nginx/ssl && chmod 755 /etc/nginx/ssl

COPY ./conf/ /etc/nginx/conf.d/

CMD ["nginx", "-g", "daemon off;"]
