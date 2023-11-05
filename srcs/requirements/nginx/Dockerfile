FROM debian:buster

RUN apt-get update && apt-get -y install nginx gettext openssl \
&& rm -rf /var/lib/apt/lists/*

RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/ssl/${LOGIN}.42.fr.pem -keyout /etc/ssl/${LOGIN}.42.fr.key -subj "/C=FR/ST=Paris/L=Paris/O=42 School/OU=${LOGIN}/CN=${LOGIN}.42.fr"

COPY conf/nginx.conf /etc/nginx/conf.template
RUN envsubst '$LOGIN' <  /etc/nginx/conf.template > /etc/nginx/conf.d/nginx.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
