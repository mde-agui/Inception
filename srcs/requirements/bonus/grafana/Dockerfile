FROM debian:bullseye

RUN apt update && apt install -y wget gnupg2 curl

RUN echo "deb https://packages.grafana.com/oss/deb stable main" > /etc/apt/sources.list.d/grafana.list && \
	wget -q -O - https://packages.grafana.com/gpg.key | apt-key add - && \
	apt update && apt install -y grafana

EXPOSE 3000

CMD ["/usr/sbin/grafana-server", "--homepath=/usr/share/grafana"]

