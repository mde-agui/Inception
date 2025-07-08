FROM debian:bullseye

RUN echo "deb http://deb.debian.org/debian bullseye main" > /etc/apt/sources.list && \
	echo "deb http://deb.debian.org/debian-security bullseye-security main" >> /etc/apt/sources.list && \
	echo "deb http://deb.debian.org/debian bullseye-updates main" >> /etc/apt/sources.list

RUN apt update && apt install -y mariadb-server

RUN mkdir -p /docker-entrypoint-initdb.d

COPY ./init.sql /docker-entrypoint-initdb.d/init.sql

RUN chown -R mysql:mysql /var/lib/mysql && \
	chmod -R 755 /var/lib/mysql

EXPOSE 3306

CMD ["mysqld", "--user=mysql", "--init-file=/docker-entrypoint-initdb.d/init.sql"]
