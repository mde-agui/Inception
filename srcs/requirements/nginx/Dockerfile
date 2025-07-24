FROM debian:bullseye

RUN echo "deb http://deb.debian.org/debian bullseye main" > /etc/apt/sources.list && \
	echo "deb http://deb.debian.org/debian-security bullseye-security main" >> /etc/apt/sources.list && \
	echo "deb http://deb.debian.org/debian bullseye-updates main" >> /etc/apt/sources.list

RUN apt update && apt install -y nginx openssl net-tools procps curl file

COPY ./generate-ssl.sh /generate-ssl.sh
RUN chmod +x /generate-ssl.sh

COPY ./nginx.conf /etc/nginx/nginx.conf
COPY mime.types /etc/nginx/mime.types

EXPOSE 443

CMD ["/bin/bash", "-c", "/generate-ssl.sh && nginx -g 'daemon off;'"]
