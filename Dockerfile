FROM node:19-alpine as build

RUN mkdir /build
WORKDIR /build

# cache npm dependencies between builds
COPY package.json package-lock.json webpack.config.js ./
RUN npm ci

COPY src ./src
RUN npm run build

FROM nginx:mainline-alpine as production
COPY --from=build /build/dist/* /usr/share/nginx/html/

FROM build as development
RUN npm install && \
    echo "#!/usr/bin/env sh" > /start-dev.sh && \
    echo "npm install && npm run start-docker" > /start-dev.sh && \
    chmod a+x /start-dev.sh

CMD ["/start-dev.sh"]