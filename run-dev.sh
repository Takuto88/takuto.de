#!/usr/bin/env sh

docker build --target build -t takuto-de:dev .
docker run --rm -ti --name takuto-de-dev --entrypoint=npm -v $(pwd):/build -p 8080:8080 takuto-de:dev start

