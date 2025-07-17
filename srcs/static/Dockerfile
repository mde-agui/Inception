FROM debian:bullseye

RUN apt update && apt install nginx

COPY ./site /var/www/static
COPY ./nginx.conf /etc/nginx/nginx.conf

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
