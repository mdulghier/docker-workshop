docker build -t mdulghier/consul-acl .
docker run -d --name consul --net=host mdulghier/consul -server -bootstrap -ui-dir /ui
