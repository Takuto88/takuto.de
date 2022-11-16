#!/usr/bin/env sh

docker build --target development -t takuto-de:dev .
docker run --rm -ti --name takuto-de-dev -v $(pwd):/build -p 8080:8080 takuto-de:dev

