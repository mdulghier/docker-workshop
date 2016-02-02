docker-machine create \
	--driver=digitalocean \
	--digitalocean-access-token=$DO_KEY \
	consul-1 &


docker-machine create \
	--driver=digitalocean \
	--digitalocean-access-token=$DO_KEY \
	consul-2 &

docker-machine create \
	--driver=digitalocean \
	--digitalocean-access-token=$DO_KEY \
	consul-3 &

wait
echo "Consul cluster machines ready"


eval $(docker-machine env consul-1)
docker run -d --name consul --net=host progrium/consul -server -advertise $(docker-machine ip consul-1) -bootstrap-expect 3 -ui-dir /ui

eval $(docker-machine env consul-2)
docker run -d --name consul --net=host progrium/consul -server -advertise $(docker-machine ip consul-2) -join $(docker-machine ip consul-1)

eval $(docker-machine env consul-3)
docker run -d --name consul --net=host progrium/consul -server -advertise $(docker-machine ip consul-3) -join $(docker-machine ip consul-1)


echo "=====> Consul cluster available at http://$(docker-machine ip consul-1):8500/ui"
