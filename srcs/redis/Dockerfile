FROM debian:bullseye

RUN apt update && apt install -y redis-server

COPY ./redis.conf /etc/redis.conf

COPY ./redis-setup.sh /redis-setup.sh

RUN chmod +x /redis-setup.sh

EXPOSE 6379

ENTRYPOINT ["/redis-setup.sh"]
