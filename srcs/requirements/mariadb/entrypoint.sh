#!/bin/sh
--set -e

MYSQL_ROOT_PASSWORD=${DB_ROOT_PASS}
DB_USER=${DB_USER}
DB_PASS=${DB_PASS}
WP_ADMIN_USER=${WP_ADMIN_USER}
WP_ADMIN_PASS=${WP_ADMIN_PASS}

export MYSQL_ROOT_PASSWORD DB_USER DB_PASS WP_ADMIN_USER WP_ADMIN_PASS

echo "Fixing permissions..."
chown -R mysql:mysql /var/lib/mysql /run/mysqld
chmod -R 755 /var/lib/mysql /run/mysqld

if [ ! -d /var/lib/mysql/mysql ]; then
  echo "Initializing database..."
  mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

echo "Starting MariaDB..."

mysqld --user=mysql --datadir=/var/lib/mysql --socket=/run/mysqld/mysqld.sock --bind-address=0.0.0.0 &

MAX_RETRIES=30
count=0
until mysqladmin ping -h localhost -u root -p"${MYSQL_ROOT_PASSWORD}" --silent; do
  echo "Waiting for MariaDB to be ready..."
  sleep 2
  count=$((count+1))
  if [ $count -ge $MAX_RETRIES ]; then
    echo "MariaDB did not start in time. Exiting."
    exit 1
  fi
done

if ! mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "USE wordpress;" 2>/dev/null; then
  echo "Running initial SQL script..."
  envsubst < /docker-entrypoint-initdb.d/init.sql | mysql -u root -p"${MYSQL_ROOT_PASSWORD}"
fi

wait

