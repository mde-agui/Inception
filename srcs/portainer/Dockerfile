FROM debian:bullseye

RUN apt update && apt install -y wget curl
RUN wget https://github.com/portainer/portainer/releases/download/2.19.5/portainer-2.19.5-linux-amd64.tar.gz && \
	tar xvf portainer-2.19.5-linux-amd64.tar.gz && \
	mv portainer/portainer /usr/local/bin && \
	rm -rf portainer*

EXPOSE 9014

CMD ["/usr/local/bin/portainer", "--no-auth"]
