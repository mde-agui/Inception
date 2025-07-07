FROM debian:bullseye

RUN apt update && apt install -y php-fpm php-mysql curl

RUN mkdir -p /var/www/html && \
	curl -o /tmp/wordpress.tar.gz https://wordpress.org/latest.tar.gz && \
	tar -xzf /tmp/wordpress.tar.gz -C /var/www/html --strip-components=1 && \
	rm /tmp/wordpress.tar.gz

RUN chown -R www-data:www-data /var/www/html && \
	chmod -R 755 /var/www/html

#COPY ./wp-config.php /var/www/html/wp-config.php

EXPOSE 9000

CMD ["php-fpm", "-F"]

