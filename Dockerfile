FROM ubuntu:17.10
MAINTAINER RazzDazz
# Using instructions from
# https://www.digitalocean.com/community/tutorials/how-to-install-prometheus-on-ubuntu-16-04

ENV PROMETHEUS_VER v2.6.0
ENV PROMETHEUS_TAR prometheus-2.6.0.linux-amd64.tar.gz
ENV PROMETHEUS_TAR_FOLDER prometheus-2.6.0.linux-amd64

ENV REFRESHED_AT 2019-01-05
ENV DEBIAN_FRONTEND noninteractive

# Update packages, install apache, free diskspace
RUN apt-get -yqq update && \
    apt-get -yqq upgrade && \
    apt-get -yqq install curl && \
    apt-get -yqq install supervisor && \
    rm -rf /var/lib/apt/lists/*

# Create Folders
RUN mkdir /etc/prometheus
RUN mkdir /var/lib/prometheus
RUN mkdir /opt/prometheus

# Download and extract prometheus sourcen
RUN mkdir -p /tmp/prometheus && \
    cd /tmp/prometheus/ && \
    curl -LO https://github.com/prometheus/prometheus/releases/download/${PROMETHEUS_VER}/${PROMETHEUS_TAR} && \
    tar xvf ${PROMETHEUS_TAR} && \
    cp ${PROMETHEUS_TAR_FOLDER}/prometheus /usr/local/bin/ && \
    cp ${PROMETHEUS_TAR_FOLDER}/promtool /usr/local/bin/ && \
    cp -r ${PROMETHEUS_TAR_FOLDER}/consoles /etc/prometheus && \
    cp -r ${PROMETHEUS_TAR_FOLDER}/console_libraries /etc/prometheus && \
    rm -rf /tmp/prometheus
    
# Copy prometheus.yml into container
COPY prometheus.yml /tmp/prometheus.yml.sample

# Copy helper scripts into container
COPY docker-entrypoint.sh /tmp/
RUN chmod 777 /tmp/docker-entrypoint.sh
COPY supervisor_prometheus.conf /tmp/

#
EXPOSE 9090

VOLUME /var/log/supervisor
VOLUME /var/lib/prometheus
VOLUME /opt/prometheus
           
# Start prometheus using supervisor (useful later to start other apps like node exporter)
CMD ["/tmp/docker-entrypoint.sh"]
