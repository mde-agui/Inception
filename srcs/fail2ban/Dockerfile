FROM debian:bullseye

RUN apt update && apt install -y fail2ban

COPY ./jail.local /etc/fail2ban/jail.local

CMD ["/usr/bin/fail2ban-server", "-f"]
