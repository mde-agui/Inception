FROM debian:bullseye

RUN apt update && apt install -y fail2ban

COPY ./jail.local /etc/fail2ban/jail.local
COPY ./filter.d /etc/fail2ban/filter.d
COPY ./action.d /etc/fail2ban/action.d
COPY ./setup-fail2ban.sh /setup-fail2ban.ah

RUN chmod +x /setup-fail2ban.sh

ENTRYPOINT ["/setup-fail2ban.sh"]

CMD ["/usr/bin/fail2ban-server", "-f"]
