#!/bin/bash
if [ ! -f "/tmp/prometheus/prometheus.yml" ] 
then
    echo "Copying prometheus.yml.sample to prometheus.yml for first start to volume..." 
    cp /tmp/prometheus.yml.sample /tmp/prometheus/prometheus.yml
    # chown prometheus:prometheus /tmp/prometheus/prometheus.yml 
fi

echo "Starting supervisord to run prometheus ..." 
exec /usr/bin/supervisord --nodaemon --configuration /tmp/supervisor_prometheus.conf
