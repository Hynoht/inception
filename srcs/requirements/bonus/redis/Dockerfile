FROM debian:bullseye

RUN apt update -y &&\
	apt install redis-server -y && rm -rf /var/lib/apt/lists/*

COPY conf/redis.conf /etc/redis/redis.conf
COPY tools/run.sh /usr/bin/run.sh

RUN chmod +x /usr/bin/run.sh

CMD ["/usr/bin/run.sh"]
