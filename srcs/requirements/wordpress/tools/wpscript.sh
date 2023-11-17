#!/bin/bash

sleep 20
cd /var/www/html/wordpress


if wp core is-installed --allow-root; then
	echo "Wordpress is allready installed"
else
wp core download	--allow-root;

wp config create	--allow-root \
			--dbname=${MYSQL_DATABASE} \
			--dbuser=${MYSQL_USER} \
			--dbpass=${MYSQL_PASSWORD} \
			--dbhost=${MYSQL_HOST} \
			--url=https://${DOMAIN_NAME};

wp core install		--allow-root \
			--url=https://${DOMAIN_NAME} \
			--title=${SITE_TITLE} \
			--admin_user=${ADMIN_USER} \
			--admin_password=${ADMIN_PASSWORD} \
			--admin_email=${ADMIN_EMAIL};

wp user create		--allow-root \
			${USER_LOGIN} ${USER_MAIL} \
			--role=author \
			--user_pass=${USER_PASS} ;

wp cache flush		--allow-root;


# remove default themes and plugins
wp plugin delete hello --allow-root

wp theme install twentytwentytwo --allow-root
wp theme activate twentytwentytwo --allow-root

# set the site language to English
wp language core install en_US --allow-root --activate;

# set the permalink structure
wp rewrite structure '/%postname%/' --allow-root;

fi

if [ ! -d /run/php ]; then
	mkdir /run/php;
fi

# start the PHP FastCGI Process Manager (FPM) for PHP version 7.4 in the foreground
exec /usr/sbin/php-fpm7.4 -F -R
