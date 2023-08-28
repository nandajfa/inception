FROM debian:bullseye

RUN apt update -y && apt upgrade -y && \
        apt install nginx -y && apt install openssl -y

RUN mkdir -p /etc/nginx/ssl && \
        openssl req -batch -x509 -sha256 -nodes -newkey rsa:2048 -days 365 \
        -keyout /etc/nginx/ssl/inception.key \
        -out /etc/nginx/ssl/inception.crt \
        -subj "/C=BR/ST=SP/L=SP/O=42sp/CN=$DOMAIN_NAME/UID=jefernan"

COPY ./conf/nginx.conf /etc/nginx/conf.d

RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
