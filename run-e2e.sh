#!/usr/bin/env sh
set -e

docker build -t takuto-de-e2e tests
docker run --rm --name takuto-de-e2e --network takuto-site -v $(pwd)/tests:/e2e takuto-de-e2e --env type=actual