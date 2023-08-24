FROM debian:bullseye

RUN apt update -y && apt upgrade -y && \
    apt install mariadb-server -y

COPY ./conf/my.cnf /etc/mysql/my.cnf

RUN chown -R mysql:mysql /var/lib/mysql

COPY ./tools/entrypoint.sh entrypoint.sh

RUN chmod +x entrypoint.sh

EXPOSE 3306

ENTRYPOINT [ "/entrypoint.sh" ]

CMD ["usr/bin/mysqld_safe"]