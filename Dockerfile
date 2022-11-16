FROM node:18-alpine as build

RUN mkdir /build
WORKDIR /build

# cache npm dependencies between builds
COPY package.json package-lock.json webpack.config.js ./
RUN npm ci

COPY src ./src
RUN npm run build

FROM nginx:mainline-alpine as production
COPY --from=build /build/dist/* /usr/share/nginx/html/
