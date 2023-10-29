ARG CONTAINER_NANE=nginx
ARG CODE_VERSION=11
FROM debian:${CODE_VERSION} AS nginx_installation

RUN apt-get update -y \
&& apt-get -y install \
	gettext \
	nginx \
	openssl \
&& rm -rf /var/lib/apt/lists/*

FROM nginx_installation

RUN openssl \
	req \
	-newkey rsa:4096 \
	-x509 -sha256 \
	-days 365 \
	-nodes \
	-out /etc/ssl/${MYSQL_USER}.42.fr.pem \
	-keyout /etc/ssl/${MYSQL_USER}.42.fr.key \
	-subj "/C=FR/ST=Paris/L=Paris/O=42 School/OU=${MYSQL_USER}/CN=${MYSQL_USER}.42.fr"

RUN mkdir -p /var/run/nginx
COPY ./conf/nginx.conf.template /etc/nginx/conf.d.template
RUN envsubst < /etc/nginx/conf.d.template > /etc/nginx/nginx.conf

RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
