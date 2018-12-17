FROM ubuntu:17.10
MAINTAINER RazzDazz
# Using instructions from
# https://www.digitalocean.com/community/tutorials/how-to-install-prometheus-on-ubuntu-16-04

# Create User
RUN useradd --no-create-home --shell /bin/false prometheus
RUN useradd --no-create-home --shell /bin/false node_exporter
