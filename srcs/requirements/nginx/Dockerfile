FROM debian:buster AS nginx_installation

RUN apt-get update -y \
&& apt-get -y install \
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
	-out /etc/ssl/yboudoui.42.fr.pem \
	-keyout /etc/ssl/yboudoui.42.fr.key \
	-subj "/C=FR/ST=Paris/L=Paris/O=42 School/OU=yboudoui/CN=yboudoui.42.fr"

RUN mkdir -p /var/run/nginx
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

RUN chown -R www-data:www-data /var/www/* \
&& chmod -R 755 /var/www/*

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
