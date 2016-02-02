#!/bin/bash

docker run -d -p 9090:9090 \
	-v $(pwd)/prometheus.yml:/etc/prometheus/prometheus.yml \
	--name prometheus prom/prometheus

docker run --name exporter -d -p 9104:9104 \
	-v /sys/fs/cgroup:/cgroup -v /var/run/docker.sock:/var/run/docker.sock prom/container-exporter
