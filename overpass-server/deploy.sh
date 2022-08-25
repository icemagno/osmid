#! /bin/sh

docker ps -a | awk '{ print $1,$2 }' | grep hiparco/overpass-api:1.0 | awk '{print $1 }' | xargs -I {} docker rm -f {}
docker rmi hiparco/overpass-api:1.0

DOCKER_BUILDKIT=1 docker build --tag=hiparco/overpass-api:1.0 --rm=true .

docker run --name overpass --hostname=overpass \
  -e OVERPASS_META=yes \
  -e OVERPASS_MODE=init \
  -e OVERPASS_PLANET_URL=https://download.geofabrik.de/south-america/brazil/sudeste-latest.osm.bz2 \
  -e OVERPASS_DIFF_URL=https://planet.openstreetmap.org/replication/minute/ \
  -e OVERPASS_RULES_LOAD=10 \
  -e OVERPASS_FASTCGI_PROCESSES=6 \
  -v /srv/overpass/:/db \
  -p 36745:80 \
  -d wiktorn/overpass-api


# https://github.com/wiktorn/Overpass-API