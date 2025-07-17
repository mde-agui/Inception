#!/bin/bash

set -e

if ! id "$FTP_USER" &>/dev/null; then
	adduser --disabled-password --gecos "" "$FTP_USER"
	echo "$FTP_USER:$FTP_PASS" | chpasswd
fi

mkdir -p /var/www/html
chown -R "$FTP_USER":"$FTP_USER" /var/www/html
chmod 755 /var/www/html

unset FTP_USER FTP_PASS

exec /usr/sbin/vsftpd /etc/vsftpd.conf
