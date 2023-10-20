ARG     CONTAINER_NANE=wordpress
ARG     CODE_VERSION=11
FROM    debian:${CODE_VERSION}

RUN     apt-get update \
    &&  apt-get -y install \
            wget \
            php \
            php-cgi \
            php-mysql \
            php-fpm \
            php-pdo \
            php-gd php-cli \
            php-mbstring \
    &&  rm -rf /var/lib/apt/lists/*

FROM    installation_${CONTAINER_NANE}:${CODE_VERSION}

COPY ./conf/www.conf /var/www/html/

RUN mkdir /run/php

COPY ./tools/create_wordpress.sh /usr/local/bin/
ENTRYPOINT ["create_wordpress.sh"]

WORKDIR /var/www/html/

EXPOSE 9000

CMD ["/usr/sbin/php-fpm7.3", "-F"]
