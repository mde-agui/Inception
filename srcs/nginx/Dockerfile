FROM debian:bullseye

RUN apt update && apt install -y nginx openssl

RUN mkdir /etc/nginx/ssl && \
	openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/nginx/ssl/nginx.key \
	-out /etc/nginx/ssl/nginx.crt \
	-subj "/C=PT/ST=State/L=City/O=42school/OU=Inception/CN=${DOMAIN_NAME}"

COPY ./nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
