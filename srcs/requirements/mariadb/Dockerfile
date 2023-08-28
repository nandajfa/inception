FROM debian:bullseye

RUN apt update -y && apt upgrade -y && \
    apt install mariadb-server -y

RUN mkdir -p /var/lib/mysql /var/run/mysqld \ 
    && chown -R mysql:mysql /var/lib/mysql /var/run/mysqld \
    && chmod 755 /var/run/mysqld

COPY ./conf/my.cnf /etc/mysql/mariadb.conf.d/
COPY ./tools/entrypoint.sh entrypoint.sh

RUN chmod 644 /etc/mysql/mariadb.conf.d/my.cnf
RUN chmod +x entrypoint.sh

USER mysql

EXPOSE 3306

ENTRYPOINT [ "/entrypoint.sh" ]
