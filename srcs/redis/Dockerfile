FROM debian:bulleye

RUN apt update && apt install -y redis-server

RUN sed -i 's/bind 127.0.0.1 ::1/bind 0.0.0.0/' /etc/redis/redis.conf && \
	sed -i 's/# requirepass foobared/requirepass ${REDIS_PASS}/' /etc/redis/redis.conf

EXPOSE 6379

CMD ["redis-server", "--protected-mode", "no"]
