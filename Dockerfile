FROM ubuntu:17.10
MAINTAINER RazzDazz
# Using instructions from
# https://www.digitalocean.com/community/tutorials/how-to-install-prometheus-on-ubuntu-16-04

ENV PROMETHEUS_TAR prometheus-2.0.0.linux-amd64.tar.gz
ENV PROMETHEUS_TAR_FOLDER prometheus-2.0.0.linux-amd64

EXPOSE 9090
 
# Update packages, install apache, free diskspace
RUN apt-get -yqq update && \
    apt-get -yqq upgrade && \
    apt-get -yqq install curl && \
    apt-get -yqq install nano && \
    rm -rf /var/lib/apt/lists/*

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
RUN mkdir -p /tmp/prometheus && \
    cd /tmp/prometheus/ && \
    curl -LO https://github.com/prometheus/prometheus/releases/download/v2.0.0/${PROMETHEUS_TAR} && \
    tar xvf ${PROMETHEUS_TAR} && \
    cp ${PROMETHEUS_TAR_FOLDER}/prometheus /usr/local/bin/ && \
    cp ${PROMETHEUS_TAR_FOLDER}/promtool /usr/local/bin/ && \
    cp -r ${PROMETHEUS_TAR_FOLDER}/consoles /etc/prometheus && \
    cp -r ${PROMETHEUS_TAR_FOLDER}/console_libraries /etc/prometheus && \
    rm -rf /tmp/prometheus
    
# Again Set User Rights
RUN chown prometheus:prometheus /usr/local/bin/prometheus
RUN chown prometheus:prometheus /usr/local/bin/promtool
RUN chown -R prometheus:prometheus /etc/prometheus/consoles
RUN chown -R prometheus:prometheus /etc/prometheus/console_libraries

# Copy prometheus.yml into container
COPY prometheus.yml /etc/prometheus/

# Again Set User Rights
RUN chown prometheus:prometheus /etc/prometheus/prometheus.yml

# run shell to keep container alive for testing
CMD /bin/bash
