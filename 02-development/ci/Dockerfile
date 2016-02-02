FROM jenkins

USER root
RUN apt-get update -yqq && \
    apt-get install apt-transport-https -yqq && \
    apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D && \
    echo "deb https://apt.dockerproject.org/repo debian-jessie main" >> /etc/apt/sources.list.d/docker.list && \
    apt-get update -yqq && \
    apt-get install docker-engine -yqq

USER jenkins
