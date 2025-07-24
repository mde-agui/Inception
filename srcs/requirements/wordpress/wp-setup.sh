#!/bin/bash
set -e

DEBUG_LOG="/var/www/html/wp-debug.log"
DB_HOST=${WORDPRESS_DB_HOST:-mariadb}
DB_NAME=${WORDPRESS_DB_NAME:-${DB_NAME}}
DB_USER=${WORDPRESS_DB_USER:-${DB_USER}}
DB_PASS=${WORDPRESS_DB_PASSWORD:-${DB_PASS}}
WP_ADMIN_USER=${WP_ADMIN_USER:-${WP_ADMIN_USER}}
WP_ADMIN_PASS=${WP_ADMIN_PASS:-${WP_ADMIN_PASS}}
DOMAIN_NAME=${DOMAIN_NAME:-${DOMAIN_NAME}}
REDIS_PASS=${REDIS_PASS:-${REDIS_PASS}}

echo "DB_HOST: ${WORDPRESS_DB_HOST:-mariadb}" >> /var/www/html/wp-debug.log
echo "DB_NAME: ${WORDPRESS_DB_NAME:-${DB_NAME}}" >> /var/www/html/wp-debug.log
echo "DB_USER: ${WORDPRESS_DB_USER:-${DB_USER}}" >> /var/www/html/wp-debug.log
echo "DB_PASS: ${WORDPRESS_DB_PASSWORD:-${DB_PASS}}" >> /var/www/html/wp-debug.log
echo "WP_ADMIN_USER: ${WP_ADMIN_USER:-${WP_ADMIN_USER}}" >> /var/www/html/wp-debug.log
echo "WP_ADMIN_PASS: ${WP_ADMIN_PASS:-${WP_ADMIN_PASS}}" >> /var/www/html/wp-debug.log
echo "DOMAIN_NAME: ${DOMAIN_NAME:-${DOMAIN_NAME}}" >> /var/www/html/wp-debug.log
echo "REDIS_PASS: ${REDIS_PASS:-${REDIS_PASS}}" >> /var/www/html/wp-debug.log

echo "DB_HOST: $DB_HOST" >> /var/www/html/wp-debug.log
echo "DB_NAME: $DB_NAME" >> /var/www/html/wp-debug.log
echo "DB_USER: $DB_USER" >> /var/www/html/wp-debug.log
echo "DB_PASS: $DB_PASS" >> /var/www/html/wp-debug.log
echo "REDIS_PASS: $REDIS_PASS" >> /var/www/html/wp-debug.log

export DB_HOST DB_NAME DB_USER DB_PASS REDIS_PASS

echo "Testing database connection..." >> /var/www/html/wp-debug.log
if mysql -h mariadb -P 3306 -u $DB_USER -p$DB_PASS -e "USE $DB_NAME; SELECT 1;" 2>> /var/www/html/wp-debug.log; then
	echo "Database connection successful!" >> /var/www/html/wp-debug.log
else
	echo "Database connection failed..." >> /var/www/html/wp-debug.log
fi

if [ ! -f /var/www/html/wp-config.php ]; then
	sed -e "s|\${DB_HOST}|$DB_HOST|g" \
		-e "s|\${DB_NAME}|$DB_NAME|g" \
		-e "s|\${DB_USER}|$DB_USER|g" \
		-e "s|\${DB_PASS}|$DB_PASS|g" \
		-e "s|\${REDIS_PASS}|$REDIS_PASS|g" \
		/var/www/html/wp-config.php.template > /var/www/html/wp-config.php
	cat /var/www/html/wp-config.php >> /var/www/html/wp-debug.log
	chown www-data:www-data /var/www/html/wp-config.php
	chmod 640 /var/www/html/wp-config.php
	echo "Generated wp-config.php" >> /var/www/html/wp-debug.log
fi

for i in {1..30}; do
	if mysqladmin ping -h "$DB_HOST" -P 3306 -u "$DB_USER" -p"$DB_PASS" --silent; then
		echo "MariaDB is ready" >> /var/www/html/wp-debug.log
		break
	fi
	echo "Waiting for MariaDB to be ready (attempt $i/30)..." >> /var/www/html/wp-debug.log
	sleep 2
done

if ! wp core is-installed --path=/var/www/html --allow-root 2>> "$DEBUG_LOG"; then
    echo "Installing WordPress..." >> "$DEBUG_LOG"
    wp core install \
        --path=/var/www/html \
        --url="https://${DOMAIN_NAME}" \
        --title="Mde-agui Inceptions Site" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASS" \
        --admin_email="admin@${DOMAIN_NAME}" \
        --skip-email \
        --allow-root >> "$DEBUG_LOG" 2>&1 || echo "WordPress installation failed" >> "$DEBUG_LOG"

    echo "Installing and enabling Redis plugin..." >> "$DEBUG_LOG"
    wp plugin install redis-cache --activate --path=/var/www/html --allow-root >> "$DEBUG_LOG" 2>&1
    wp redis enable --path=/var/www/html --allow-root >> "$DEBUG_LOG" 2>&1
else
    echo "WordPress is already installed." >> "$DEBUG_LOG"
fi

echo "Fixing permissions..." >> /var/www/html/wp-debug.log
chown -R www-data:www-data /var/www/html >> /var/www/html/wp-debug.log 2>&1
chmod -R 755 /var/www/html >> /var/www/html/wp-debug.log 2>&1
chmod 640 /var/www/html/wp-config.php >> /var/www/html/wp-debug.log 2>&1

echo "Starting PHP-FPM" >> /var/www/html/wp-debug.log
exec php-fpm7.4 -F
