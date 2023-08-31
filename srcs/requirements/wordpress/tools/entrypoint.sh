#!/bin/bash

if [ ! -f "/var/www/html/wp-config.php" ]; then

        rm -rf *.*

        wp core download --allow-root
        
        mv wp-config-sample.php wp-config.php

	sed -i "s/database_name_here/$WP_DATABASE/g" wp-config.php
        sed -i "s/username_here/$WP_ADMIN_USER/g" wp-config.php
	sed -i "s/password_here/$WP_ADMIN_PWD/g" wp-config.php
	sed -i "s/localhost/$WP_HOST/g" wp-config.php

        wp core install --allow-root \
            --url=$DOMAIN_NAME \
            --title=$TITLE \
            --admin_user=$WP_ADMIN_USER \
            --admin_email=$WP_ADMIN_EMAIL \
            --admin_password=$WP_ADMIN_PWD \
            --skip-email

        wp user create --allow-root --user_login=$WP_USER --user_email=$WP_EMAIL --role=author --user_pass=$WP_PASSWORD

        wp plugin uninstall akismet hello --allow-root
        wp plugin update --all --allow-root

        chown -R www-data:www-data /var/www/html

fi

exec php-fpm7.4 -F
