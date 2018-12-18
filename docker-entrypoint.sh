#!/bin/bash
if [ ! -f "/etc/prometheus/prometheus.yml" ] 
then
    echo "Copying prometheus.yml.sample to prometheus.yml for first start to volume..." 
    cp -r /etc/prometheus/prometheus.yml.sample /etc/prometheus/prometheus.yml
    chown prometheus:prometheus /etc/prometheus/prometheus.yml 
fi

echo "Starting supervisord to run prometheus ..." 
exec /usr/bin/supervisord --nodaemon --configuration /tmp/supervisor_prometheus.conf
