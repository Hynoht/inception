FROM debian:bullseye

RUN apt update -y && apt install -y mariadb-server \
	&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/mysqld /var/lib/mysql && chown -R mysql:mysql /run/mysqld /var/lib/mysql

COPY ./tools/init.sh ./init.sh

RUN rm /etc/mysql/mariadb.conf.d/50-server.cnf && chmod +x /init.sh

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

ENTRYPOINT ["./init.sh"]
