FROM debian:bullseye

RUN apt update && apt install -y vsftpd openssl filezilla

COPY ./vsftpd.conf /etc/vsftpd.conf
COPY ./ftp-setup.sh /ftp-setup.sh

RUN chmod +x /ftp-setup.sh

RUN mkdir -p /var/run/vsftpd/empty && \
	chown root:root /var/run/vsftpd/empty && \
	chmod 555 /var/run/vsftpd/empty

ARG DOMAIN_NAME

RUN openssl req -x509 -nodes -days 365 \
	-newkey rsa:2048 \
	-keyout /etc/ssl/private/vsftpd.key \
	-out /etc/ssl/certs/vsftpd.crt \
	-subj "/C=PT/ST=Porto/L=Porto/O=42Porto/OU=FTP/CN=${DOMAIN_NAME}"

EXPOSE 21 20 10000-10100

ENTRYPOINT ["/ftp-setup.sh"]
