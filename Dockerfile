FROM nginx:latest
COPY ./nginx-config/load-balanced-reverse-proxy.conf /etc/nginx/conf.d/default.conf
COPY ./nginx-config/ssl /etc/ssl/
COPY ./nginx-config/html /var/www/html/
