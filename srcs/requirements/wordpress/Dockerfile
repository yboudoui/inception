FROM debian:bullseye AS wordpress_installation

RUN apt-get update -y \
&&	apt-get install -y \
		wget \
		php \
		php-fpm \
		php-mysql \
		mariadb-client \
		default-mysql-client \
&&	rm -rf /var/lib/apt/lists/*

FROM wordpress_installation AS wordpress_cli

RUN wget \
	-P /usr/local/bin/ \
	-O /usr/local/bin/wp \
	https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
&& chmod +x /usr/local/bin/wp

FROM wordpress_cli AS wordpress_archive

RUN mkdir -p /var/www/html/wordpress \
&& chown -R www-data:www-data /var/www/* \
&& chmod -R 755 /var/www/*

FROM wordpress_archive AS wordpress_import_files

COPY ./tools/wpscript.sh ./wpscript.sh
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

FROM wordpress_import_files

EXPOSE 9000
RUN chmod +x ./wpscript.sh
ENTRYPOINT ["bash", "./wpscript.sh"]
