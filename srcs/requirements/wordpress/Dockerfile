FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt upgrade -y && \
    apt install -y php7.4 php7.4-fpm php7.4-cli php7.4-curl php7.4-mysql php7.4-mbstring php7.4-xml php7.4-gd \
    wget mariadb-client 

RUN wget -O /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar  \ 
    && chmod +x /usr/local/bin/wp \
    && wp cli update

RUN mkdir -p /run/php \
    /var/www/html && \
    chmod -R 755 /var/www/html

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

RUN chmod 755 /etc/php/7.4/fpm/pool.d/www.conf

WORKDIR /var/www/html

COPY ./tools/entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 9000

ENTRYPOINT ["entrypoint.sh"]