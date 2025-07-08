#!/bin/bash
set -e

if [ -z "$DOMAIN_NAME" ]; then
	echo "Error: DOMAIN_NAME environment variable is not set!"
	exit 1
fi

mkdir -p /etc/nginx/ssl

cat > /etc/nginx/ssl/openssl.cnf <<EOF
[req]
default_bits = 2048
prompt = no
default_md = sha256
distinguished_name = dn
x509_extensions = v3_req

[dn]
C = PT
ST = State
L = City
O = 42school
OU = Inception
CN = ${DOMAIN_NAME}

[v3_req]
subjectAltName = DNS:${DOMAIN_NAME},DNS:localhost,IP:127.0.0.1
EOF

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/nginx/ssl/nginx.key \
	-out /etc/nginx/ssl/nginx.crt \
	-config /etc/nginx/ssl/openssl.cnf

chmod 600 /etc/nginx/ssl/nginx.key
chmod 644 /etc/nginx/ssl/nginx.crt
