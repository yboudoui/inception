ARG CONTAINER_NANE=mariadb
ARG CODE_VERSION=11
FROM debian:${CODE_VERSION} AS mariadb_installation

RUN apt-get update -y \
    &&  apt-get -y install \
            mariadb-server-10.3 \
            mariadb-client \
    &&  rm -rf /var/lib/apt/lists/*

FROM mariadb_installation

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

RUN mkdir -p /var/run/mysqld /var/lib/mysqld \
    &&  chown -R mysql:mysql /var/run/mysqld /var/lib/mysql \
    &&  chmod 755 /var/run/mysqld /var/lib/mysql

EXPOSE 3306

COPY ./tools/create_db.sh ./
RUN chmod +x ./create_db.sh

ENTRYPOINT ["bash", "create_db.sh"]

#CMD ["mysqld", "--bind-address=0.0.0.0"]
