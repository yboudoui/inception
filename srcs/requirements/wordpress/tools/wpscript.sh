#!/bin/bash

LOCAL_PATH=/var/www/html
cd $LOCAL_PATH

set -eux

ls -la
if ls -A1q wordpress | grep -q .
then
	echo "Wordpress is allready downloaded"
else
#if [ ! -d ./wordpress ]; then
wp core download	--allow-root \
			--path=${LOCAL_PATH}/wordpress ;
fi

#ls -la wordpress

if [ ! -f wp-config.php ]; then
wp config create	--allow-root \
			--path=${LOCAL_PATH}/wordpress \
			--dbname=${MYSQL_DATABASE} \
			--dbuser=${MYSQL_USER} \
			--dbpass=${MYSQL_PASSWORD} \
			--dbhost=${MYSQL_HOST} \
			--url=https://${DOMAIN_NAME};
fi

if ! wp core is-installed --allow-root; then
wp core install		--allow-root \
			--url=https://${DOMAIN_NAME} \
			--title=${SITE_TITLE} \
			--admin_user=${ADMIN_USER} \
			--admin_password=${ADMIN_PASSWORD} \
			--admin_email=${ADMIN_EMAIL};

wp user create		--allow-root \
			${USER1_LOGIN} ${USER1_MAIL} \
			--role=author \
			--user_pass=${USER1_PASS} ;

wp cache flush --allow-root;


# set the site language to English
wp language core install en_US --allow-root --activate;

# set the permalink structure
wp rewrite structure '/%postname%/' --allow-root;

fi

if [ ! -d /run/php ]; then
	mkdir /run/php;
fi

# start the PHP FastCGI Process Manager (FPM) for PHP version 7.3 in the foreground
exec /usr/sbin/php-fpm7.3 -F -R
