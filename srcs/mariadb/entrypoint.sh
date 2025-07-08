#!/bin/bash
set -e

mysqld --user=mysql --datadir=/var/lib/mysql --socket=/run/mysqld/mysqld.sock &

until mysqladmin ping -h localhost -u root --silent; do
	echo "Waiting for MariaDB to be ready..."
	sleep 2
done

if [ ! -f /var/lib/mysql/wordpress ]; then
	mysql -u root -p"${DB_ROOT_PASS}" < /docker-entrypoint-initdb.d/init.sql
fi

wait
