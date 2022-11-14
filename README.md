# takuto.de website code

This repository contains the source code of my home page. It is used for updating & deploying the site.

Released under [MIT](LICENSE).

## Local dev setup (docker)

No need to have npm / nodejs installed locally, but you have to have a somewhat recent version of docker installed. 

Then simply run this:
```shell
./run-dev.sh
```

Then goto [https://localhost:8080](https://localhost:8080).

## Local dev setup (npm)

This requires node 18 and npm 8 or greater to be installed locally. Earlier versions might work too, but are not tested.

```
npm install -y && npm start
```

Then goto [https://localhost:8080](https://localhost:8080).

## Build & run production image locally

The site is deployed through docker in a simple NGINX container. To build and run it, you'll need to have docker
installed in a somewhat recent version. Then run:

````shell
./run-production.sh
````

Then goto [https://localhost:8080](https://localhost:8080).

## Attributions

I'm no frontend guy so the template was picked from [startbootstrap](https://github.com/startbootstrap/startbootstrap-resume).
Things I've done myself are the npm / webpack / docker / GCP deploy chain and the texts of course, but the eye candy
was not developed here 😉.