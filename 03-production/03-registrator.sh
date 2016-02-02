function startRegistrator {
	local machine=$1
	eval $(docker-machine env $machine)
	docker run	-d --net=host \
				-v /var/run/docker.sock:/tmp/docker.sock \
				--name registrator \
				gliderlabs/registrator consul://localhost:8500
}

startRegistrator consul-1
startRegistrator consul-2
startRegistrator consul-3

echo "======> Registrator started on consul cluster"

eval $(docker-machine env --swarm testswarm)
docker run -d -e constraint:node==testswarm --name consul --net=host progrium/consul -join $(docker-machine ip consul-1) -advertise $(docker-machine ip testswarm)
docker run -d -e constraint:node==testswarm-node-1 --name consul2 --net=host progrium/consul -join $(docker-machine ip consul-1) -advertise $(docker-machine ip testswarm-node-1)

docker run	-d --net=host \
			-v /var/run/docker.sock:/tmp/docker.sock \
			-e constraint:node==testswarm \
			--name registrator \
			gliderlabs/registrator consul://localhost:8500

docker run	-d --net=host \
			-v /var/run/docker.sock:/tmp/docker.sock \
			-e constraint:node==testswarm-node-1 \
			--name registrator2 \
			gliderlabs/registrator consul://localhost:8500

echo "======> Registrator started on swarm"

