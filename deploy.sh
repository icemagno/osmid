#! /bin/sh

docker ps -a | awk '{ print $1,$2 }' | grep hiparco/osmid:1.0 | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi hiparco/osmid:1.0

DOCKER_BUILDKIT=1 docker build --tag=hiparco/osmid:1.0 --rm=true .

docker run --name osmid --hostname=osmid \
	-v /etc/localtime:/etc/localtime:ro \
	-v /srv/:/host_drive \
	-p 36096:8080 \
	-d hiparco/osmid:1.0
