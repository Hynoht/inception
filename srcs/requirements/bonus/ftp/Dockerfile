FROM debian:bullseye

RUN apt update -y && apt install -y vsftpd \
	&& rm -rf /var/lib/apt/lists/*

COPY ./conf/vsftpd.conf /etc/vsftpd.conf
COPY ./tools/init.sh /usr/bin/init.sh

RUN chmod +x /usr/bin/init.sh

CMD ["/usr/bin/init.sh"]