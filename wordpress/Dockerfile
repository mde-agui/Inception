FROM debian:bullseye

RUN echo "deb http://deb.debian.org/debian bullseye main" > /etc/apt/sources.list && \
	echo "deb http://deb.debian.org/debian-security bullseye-security main" >> /etc/apt/sources.list && \
	echo "deb http://deb.debian.org/debian bullseye-updates main" >> /etc/apt/sources.list

RUN apt update && apt install -y php-fpm php-mysql php-redis curl net-tools mariadb-client gettext-base && \
	ln -s /usr/sbin/php-fpm7.4 /usr/sbin/php-fpm

RUN curl -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x /usr/local/bin/wp

RUN mkdir -p /run/php && \
	chown -R www-data:www-data /run/php && \
	chmod -R 755 /run/php

ARG PHPPATH=/etc/php/7.4/fpm

COPY ./www.conf ${PHPPATH}/pool.d/

RUN sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' ${PHPPATH}/php.ini && \
	sed -i 's/listen = \/run\/php\/php7.4fpm.sock/listen = 9000/g' ${PHPPATH}/pool.d/www.conf && \
	sed -i 's/listen.mode = 0660/listen.mode = 0660/g' ${PHPPATH}/pool.d/www.conf && \
	sed -i 's/;daemonize = yes/daemonize = no/g' ${PHPPATH}/pool.d/www.conf

RUN mkdir -p /var/www/html && \
	curl -o /tmp/wordpress.tar.gz https://wordpress.org/latest.tar.gz && \
	tar -xzf /tmp/wordpress.tar.gz -C /var/www/html --strip-components=1 && \
	rm /tmp/wordpress.tar.gz

COPY ./wp-config.php.template /var/www/html/wp-config.php.template
COPY ./wp-setup.sh /wp-setup.sh

RUN chown -R www-data:www-data /var/www/html && \
	chmod -R 755 /var/www/html && \
	chmod +x /wp-setup.sh

EXPOSE 9000

CMD ["/wp-setup.sh"]

