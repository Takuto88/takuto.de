# takuto.de website code

This repository contains the source code of my home page. It is used for updating & deploying the site.

Released under [MIT](LICENSE).

## Local development (Docker Compose)

 You need a recent version of Docker and Docker Compose installed.

To start the development environment:

1. Run Docker Compose:
   ```shell
   docker compose up
   ```
2. Open [http://localhost:8080](http://localhost:8080) in your browser.

## Production build & run (Docker Compose)

To build and run the production image locally:

1. Build and start the container:
   ```shell
   docker compose -f docker-compose.yml up --build
   ```
2. Open [http://localhost](http://localhost) in your browser.