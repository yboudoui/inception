ARG     CONTAINER_NANE=nginx
ARG     CODE_VERSION=11
FROM    debian:${CODE_VERSION}

RUN     apt-get update \
    &&  apt-get -y install \
            nginx \
            openssl \
    &&  rm -rf /var/lib/apt/lists/*

FROM    installation_${CONTAINER_NANE}:${CODE_VERSION}

RUN     openssl \
            req \
            -newkey rsa:4096 \
            -x509 -sha256 \
            -days 365 \
            -nodes \
            -out /etc/ssl/${MYSQL_USER}.42.fr.pem \
            -keyout /etc/ssl/${MYSQL_USER}.42.fr.key \
            -subj "/C=FR/ST=Paris/L=Paris/O=42 School/OU=${MYSQL_USER}/CN=${MYSQL_USER}.42.fr"

COPY    conf/nginx.conf /etc/nginx/conf.d

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
