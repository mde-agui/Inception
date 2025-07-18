FROM debian:bullseye

RUN apt update && apt install -y wget curl
RUN wget https://github.com/prometheus/prometheus/releases/download/v2.47.1/prometheus-2.47.1.linux-amd64.tar.gz && \
	tar xvf prometheus-2.47.1.linux-amd64.tar.gz && \
	mv prometheus-2.47.1.linux-amd64/prometheus /usr/local/bin/ && \
	mv prometheus-2.47.1.linux-amd64/promtool /usr/local/bin/ && \
	rm -rf prometheus-2.47.1.linux-amd64*

COPY ./prometheus.yml /etc/prometheus/prometheus.yml

EXPOSE 9090

CMD ["/usr/local/bin/prometheus", "--config.file=/etc/prometheus/prometheus.yml"]
