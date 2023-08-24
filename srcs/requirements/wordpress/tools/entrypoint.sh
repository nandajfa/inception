#!/bin/bash

if [ ! -f "/var/www/wordpress/wp-config.php" ]; then

    find . ! -name "entrypoint.sh" -exec rm -rf {} \;

    wp core download
    wp core config \
            --dbname=$MARIADB_DATABASE \
            --dbuser=$MARIADB_USER \
            --dbpass=$MARIADB_PASSWORD \
            --dbhost=$MARIADB_HOST \
    
    wp core install \
            --url=$DOMAIN_NAME \
            --title=$TITLE \
            --admin_user=$WP_ADMIN_USER \
            --admin_password=$WP_ADMIN_PWD \
            --admin_email=$WP_ADMIN_EMAIL \
            --skip-email

    wp user create $WP_USER $WP_EMAIL --role=author --user_pass=$WP_PWD

fi

chown -R www-data:www-data /var/www/html/*

exec php-fpm7.4 -F
