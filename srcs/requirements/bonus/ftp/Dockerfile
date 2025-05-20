FROM debian:bullseye

RUN apt update -y && apt install -y vsftpd \
	&& rm -rf /var/lib/apt/lists/*

EXPOSE 21

CMD ["/usr/sbin/vsftpd", "/etc/vsftpd.conf"]