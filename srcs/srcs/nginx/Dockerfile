FROM debian:bullseye

RUN echo "deb http://deb.debian.org/debian bullseye main" > /etc/apt/sources.list && \
	echo "deb http://deb.debian.org/debian-security bullseye-security main" >> /etc/apt/sources.list && \
	echo "deb http://deb.debian.org/debian bullseye-updates main" >> /etc/apt/sources.list

RUN apt update && apt install -y nginx openssl net-tools procps curl

COPY ./generate-ssl.sh /generate-ssl.sh

COPY ./nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

CMD ["/bin/bash", "-c", "/generate-ssl.sh && nginx -g 'daemon off;'"]
