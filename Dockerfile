FROM nginx:1.29.1-alpine

RUN rm -rf /usr/share/nginx/html/*

COPY src /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
