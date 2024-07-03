FROM docker.io/library/debian:bookworm-slim

ARG DEBIAN_FRONTED=noninteractive

COPY ./go_setup.sh /tmp/go_setup.sh

ENV PATH="/root/.local/go/bin:${PATH}"
ENV GOPATH="/root/.local/share/go"

RUN \
	set -e; \
	apt update; \
	apt upgrade -y; \
	apt install -y --no-install-recommends \
		ca-certificates wget make; \
	chmod +x /tmp/go_setup.sh; \
	/tmp/go_setup.sh; \
	rm /tmp/go_setup.sh
