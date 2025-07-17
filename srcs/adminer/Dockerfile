FROM debian:bullseye

RUN apt update && apt install -y php-fpm php-mysql nginx curl supervisor \
	&& mkdir -p /var/log/php && touch /var/log/php7.4-fpm.log

RUN curl -L https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php -o /var/www/html/adminer.php

RUN sed -i 's/;listen.mode = 0660/listen.mode = 0660/' /etc/php/7.4/fpm/pool.d/www.conf

COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./supervisord.conf /etc/supervisord.conf

RUN mkdir -p /run/php && chown www-data:www-data /run/php

RUN apt install --reinstall php7.4-fpm

RUN sed -i 's|^listen = .*|listen = 127.0.0.1:9000|' /etc/php/7.4/fpm/pool.d/www.conf

EXPOSE 8081

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
