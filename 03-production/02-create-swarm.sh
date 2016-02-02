#!/bin/bash

SWARM_NAME=testswarm
SWARM_NODES=1

echo "======> Creating swarm manager"
docker-machine create \
	--driver=digitalocean \
	--digitalocean-access-token=$DO_KEY \
	--engine-opt "cluster-store consul://$(docker-machine ip consul-1):8500" \
	--engine-opt "cluster-advertise eth0:2376" \
	--swarm \
	--swarm-master \
	--swarm-discovery consul://$(docker-machine ip consul-1):8500/ ${SWARM_NAME}

echo "======> Creating swarm nodes"
for (( i=1; i <= $SWARM_NODES; i++))
do
	docker-machine create \
		--driver=digitalocean \
		--digitalocean-access-token=$DO_KEY \
		--engine-opt "cluster-store consul://$(docker-machine ip consul-1):8500" \
		--engine-opt "cluster-advertise eth0:2376" \
		--swarm \
		--swarm-discovery consul://$(docker-machine ip consul-1):8500/ ${SWARM_NAME}-node-${i}
done
