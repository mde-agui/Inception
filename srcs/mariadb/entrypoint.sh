#!/bin/bash
set -e

mysqld --user=mysql --datadir=/var/lib/mysql --socket=/run/mysqld/mysqld.sock --bind-address=0.0.0.0 &

until mysqladmin ping -h localhost -u root -p"${MYSQL_ROOT_PASSWORD}" --silent; do
	echo "Waiting for MariaDB to be ready..."
	sleep 2
done

if [ ! -f /var/lib/mysql/wordpress ]; then
	mysql -u root -p"${MYSQL_ROOT_PASSWORD}" < /docker-entrypoint-initdb.d/init.sql
fi

wait
