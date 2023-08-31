#!/bin/bash

mysqld_safe --skip-syslog &

while ! mysqladmin ping -hlocalhost --silent; do
    sleep 1
done

if ! mysql -e "USE $WP_DATABASE;";

then

    mysql -e "CREATE DATABASE $WP_DATABASE;"
    mysql -e "CREATE USER '$WP_ADMIN_USER'@'%' IDENTIFIED BY '$WP_ADMIN_PWD';"
    mysql -e "GRANT ALL PRIVILEGES ON $WP_DATABASE.* TO '$WP_ADMIN_USER'@'%';"
    mysql -e "FLUSH PRIVILEGES;"

    echo "Database created."
else
    echo "Database '$WP_DATABASE' has already been created."
fi

mysqladmin shutdown

while mysqladmin ping -hlocalhost --silent; do
    sleep 1
done

exec mariadbd
