# Container for prometheus to run on a synology nas

## Using instructions from
https://www.digitalocean.com/community/tutorials/how-to-install-prometheus-on-ubuntu-16-04

## Exposed ports:
- 9090

## Volumes
- log directory: `/var/log/supervisor`
- data directory: `/var/lib/prometheus`
- config directory: `/opt/prometheus`

## Sample directory structure on host
```
-- prometheus
    |-- log (optional)
    |-- data
    |-- config
```
