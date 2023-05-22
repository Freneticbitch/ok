#!/bin/sh

rm -rf /var/www/html/wordpress/wp-config.php

wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost="mariadb" --path="/var/www/html/wordpress/" --allow-root --skip-check
wp config set WP_CACHE true --raw --allow-root;
wp config set WP_CACHE_KEY_SALT fforlini.42.fr --allow-root;
wp config set WP_REDIS_HOST redis --allow-root;
wp config set WP_REDIS_PORT 6379 --raw --allow-root;

if ! wp core is-installed --allow-root; then
    wp core install --url="fforlini.42.fr" --title="fforlini's wordpress site" --admin_user="fede" --admin_password="forlini" --admin_email="youremail@gmail.com" --path="/var/www/html/wordpress/" --allow-root
fi

if ! wp user get AleMarcoFede --allow-root; then
	wp user create AleMarcoFede AleMarcoFede@gucci.fr --role=author --user_pass="123" --allow-root
fi

wp plugin install redis-cache --allow-root
wp plugin activate redis-cache --allow-root
wp redis enable --force --allow-root

chown -R www-data:www-data /var/www/html/wordpress

exec php-fpm7.3 --nodaemonize
