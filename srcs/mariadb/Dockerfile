FROM debian:bullseye

RUN apt update && apt install -y mariadb-server

COPY ./init.sql /docker-entrypoint-initdb.d/init.sql

EXPOSE 3306

CMD ["mysql", "--init-file=/docker-entrypoint-initdb.d/init.sql"]
