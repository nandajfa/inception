#!/bin/bash

# service mariadb start
mysqld_safe --skip-syslog &

sleep 5

# if ! mysql -e "USE $MYSQL_DATABASE;";

# then

    mysql -e "CREATE DATABASE $WP_DATABASE;"
    mysql -e "CREATE USER '$WP_ADMIN_USER'@'%' IDENTIFIED BY '$WP_ADMIN_PWD';"
    mysql -e "GRANT ALL PRIVILEGES ON $WP_DATABASE.* TO '$WP_ADMIN_USER'@'%';"
    mysql -e "FLUSH PRIVILEGES;"

#     echo "Database created."
# else
#     echo "Database '$MYSQL_DATABASE' has already been created."
# fi

mysqladmin shutdown

sleep 5

exec mariadbd
