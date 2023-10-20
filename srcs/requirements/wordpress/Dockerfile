ARG	CONTAINER_NANE=wordpress
ARG	CODE_VERSION=11
FROM	debian:${CODE_VERSION}

RUN		apt-get update \
	&&	apt-get install \
			-y \
			wget \
			php \
			php-fpm \
			php-mysql \
			mariadb-client \
			default-mysql-client \
	&&	rm -rf /var/lib/apt/lists/*

FROM	installation_${CONTAINER_NANE}:${CODE_VERSION}

RUN		wget \
			-P /usr/local/bin/wp \
			https://raw.githubusercontent.com\
			/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&&	wget \
			-P /var/www/html \
			https://wordpress.org\
			/wordpress-6.1.1.tar.gz \
	&&	tar \
			-xzf /var/www/html/wordpress-6.1.1.tar.gz \
			-C /var/www/html/ \
	&&	rm	/var/www/html/wordpress-6.1.1.tar.gz


FROM	archives_download_${CONTAINER_NANE}:${CODE_VERSION}

COPY	./tools/wpscript.sh ./
COPY	./tools/www.conf /etc/php/7.3/fpm/pool.d/www.conf

FROM	files_copy_${CONTAINER_NANE}:${CODE_VERSION}

RUN		chmod +x /usr/local/bin/wp/wp-cli.phar \
	&&	chmod +x ./wpscript.sh \
	&&	chmod -R 755 /var/www/*
	&&	chown -R www-data:www-data /var/www/* \

FROM	files_permission_${CONTAINER_NANE}:${CODE_VERSION}

EXPOSE	9000

ENTRYPOINT	["bash", "./wpscript.sh"]
