#!/bin/bash

set -e

touch /var/www/html/wp-debug.log /var/log/vsftpd.log
chmod 644 /var/www/html/wp-debug.log /var/log/vsftpd.log

touch /etc/nginx/blocked_ips.conf
chmod 644 /etc/nginx/blocked_ips.conf

exec "$@"
