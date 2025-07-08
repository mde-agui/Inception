FROM debian:bullseye

RUN echo "deb http://deb.debian.org/debian bullseye main" > /etc/apt/sources.list && \
	echo "deb http://deb.debian.org/debian-security bullseye-security main" >> /etc/apt/sources.list && \
	echo "deb http://deb.debian.org/debian bullseye-updates main" >> /etc/apt/sources.list

RUN apt update && apt install -y mariadb-server

RUN mkdir -p /var/lib/mysql /run/mysqld /docker-entrypoint-initdb.d && \
	chown -R mysql:mysql /var/lib/mysql /run/mysqld && \
	chmod -R 755 /var/lib/mysql /run/mysqld

RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

COPY ./init.sql /docker-entrypoint-initdb.d/init.sql
COPY ./entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 3306

ENTRYPOINT ["/entrypoint.sh"]
