ARG     CONTAINER_NANE=mariadb
ARG     CODE_VERSION=11
FROM    debian:${CODE_VERSION}

RUN     apt-get update \
    &&  apt-get -y install \
            mariadb-server \
            mariadb-client \
    &&  rm -rf /var/lib/apt/lists/*

FROM    installation_${CONTAINER_NANE}:${CODE_VERSION}

COPY	conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf

RUN     mkdir -p /var/run/mysqld /var/lib/mysqld \
    &&  chown -R mysql:mysql /var/run/mysqld /var/lib/mysql \
    &&  chmod 755 /var/run/mysqld /var/lib/mysql

EXPOSE 3306

COPY	./tools/create_db.sh /usr/local/bin/
RUN	chmod +x /usr/local/bin/create_db.sh

ENTRYPOINT ["create_db.sh"]

CMD ["mysqld", "--bind-address=0.0.0.0"]
