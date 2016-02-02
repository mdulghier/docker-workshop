
eval $(docker-machine env consul-1)
docker rm -f consul

eval $(docker-machine env consul-2)
docker rm -f consul

eval $(docker-machine env consul-3)
docker rm -f consul

