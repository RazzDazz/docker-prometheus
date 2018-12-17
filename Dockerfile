FROM ubuntu:17.10
MAINTAINER RazzDazz
# Using instructions from
# https://www.digitalocean.com/community/tutorials/how-to-install-prometheus-on-ubuntu-16-04

# Create User
RUN useradd --no-create-home --shell /bin/false prometheus
RUN useradd --no-create-home --shell /bin/false node_exporter

# Create Folders
RUN mkdir /etc/prometheus
RUN mkdir /var/lib/prometheus

# Set User Rights
RUN chown prometheus:prometheus /etc/prometheus
RUN chown prometheus:prometheus /var/lib/prometheus

# Download and extract prometheus sourcen
ENV PROMETHEUS_TAR prometheus-2.0.0.linux-amd64.tar.gz

RUN mkdir -p /tmp/prometheus && \
    cd /tmp/prometheus/ && \
    curl -LO https://github.com/prometheus/prometheus/releases/download/v2.0.0/${PROMETHEUS_TAR} && \
    tar xvf ${PROMETHEUS_TAR} && \
    rm -f ${PROMETHEUS_TAR}   
