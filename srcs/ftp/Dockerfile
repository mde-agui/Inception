FROM debian:bullseye

RUN apt update && apt install -y vsftpd

COPY ./vsftpd.conf /etc/vsftpd.conf

COPY ./ftp-setup.sh /ftp-setup.sh

RUN chmod +x /ftp-setup.sh

RUN mkdir -p /var/www/html && \
	chown -R ftp:ftp /var/www/html && \
	chmod -R 755 /var/www/html

EXPOSE 21 20 1000-10100

ENTRYPOINT ["/ftp-setup.sh"]

CMD ["/usr/sbin/vsftpd", "/etc/vsftpd.conf"]
