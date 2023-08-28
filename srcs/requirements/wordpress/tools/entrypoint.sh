#!/bin/bash

WP_PATH="/var/www/html"

if [ ! -f "/var/www/html/wp-config.php" ]; then

        cd /var/www/html

        rm -rf *.*

        wp core download --allow-root
        
        mv wp-config-sample.php wp-config.php

	sed -i "s/database_name_here/$WP_DATABASE/g" wp-config.php
        sed -i "s/username_here/$WP_ADMIN_USER/g" wp-config.php
	sed -i "s/password_here/$WP_ADMIN_PWD/g" wp-config.php
	sed -i "s/localhost/$WP_HOST/g" wp-config.php

        # wp config create --allow-root \
        #     --dbname=$WP_DATABASE \
        #     --dbuser=$WP_ADMIN_USER \
        #     --dbpass=$WP_ADMIN_PWD \
        #     --dbhost=$WP_HOST \

        wp core install --allow-root \
            --url=$DOMAIN_NAME \
            --title=$TITLE \
            --admin_user=$WP_ADMIN_USER \
            --admin_email=$WP_ADMIN_EMAIL \
            --admin_password=$WP_ADMIN_PWD \
            --skip-email

        wp user create --allow-root --user_login=$WP_USER --user_email=$WP_EMAIL --role=author --user_pass=$WP_PASSWORD

        chown -R www-data:www-data "$WP_PATH"
        find "$WP_PATH" -type d -exec chmod 755 {} \;
        find "$WP_PATH" -type f -exec chmod 644 {} \;
fi

exec php-fpm7.4 -F
