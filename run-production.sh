docker build -t takuto-de:production .

docker run --rm -ti --name takuto-de-production -p 80:8080 takuto-de:production