# takuto.de website code

This repository contains the source code of my home page. It is used for updating & deploying the site.

Released under [MIT](LICENSE).

## Local development (Docker Compose)

You need a recent version of Docker and Docker Compose installed.

To start the development environment:

```shell
docker compose -f docker-compose.yml -f docker-compose.local.yml up --build
```

Open [http://localhost:8080](http://localhost:8080) in your browser.

## Production

The production setup uses `docker-compose.prod.yml` which includes nginx-proxy and acme-companion services. This is deployed via Ansible and not intended for local use.