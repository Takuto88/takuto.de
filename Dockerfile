FROM nginx:1.31.5-alpine

RUN rm -rf /usr/share/nginx/html/*

COPY src /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
