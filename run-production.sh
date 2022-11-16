docker build --target production -t takuto-de:production .

docker run --rm -ti --name takuto-de-production -p 8080:80 takuto-de:production