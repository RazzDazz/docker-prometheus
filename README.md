# Container for prometheus to run on a synology nas

## Using instructions from
https://www.digitalocean.com/community/tutorials/how-to-install-prometheus-on-ubuntu-16-04

## Exposed ports:
- 9090

## Volumes
- data directory: `/var/lib/prometheus`
- log directory: `/var/logs/supervisor`
- config file: `/etc/prometheus/prometheus.yml`

## Sample directory structure on host
```
-- prometheus
    |-- logs (optional)
    |-- data
    |-- prometheus.yml
```
