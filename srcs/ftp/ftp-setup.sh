#!/bin/bash

set -e

FTP_USER=${FTP_USER:-${FTP_USER}}
FTP_PASS=${FTP_PASS:-${FTP_PASS}}

sed -i "s|\${DOMAIN_NAME}|${DOMAIN_NAME}|g" /etc/vsftpd.conf

useradd -m -d /var/www/html -s /bin/bash ${FTP_USER}
echo "${FTP_USER}:${FTP_PASS}" | chpasswd

unset FTP_USER FTP_PASS

exec "$@"
