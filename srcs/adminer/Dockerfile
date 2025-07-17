FROM debian:bullseye

RUN apt update && apt install -y php-fpm php-mysql nginx

RUN curl -L https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php -o /var/www/html/adminer.php

COPY ./nginx.conf /etc/nginx/nginx.conf

EXPOSE 8081

CMD ["/bin/bash", "-c", "php-fpm7.4 -F & nginx -g 'daemon off;'"]
