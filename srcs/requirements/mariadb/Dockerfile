FROM debian:buster AS mariadb_installation

RUN apt-get update -y \
    &&  apt-get -y install \
	    procps \
            mariadb-server \
            mariadb-client \
    &&  rm -rf /var/lib/apt/lists/*

FROM mariadb_installation

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

RUN mkdir -p /var/run/mysqld
RUN mkdir -p /var/lib/mysql
RUN chown mysql:mysql /var/run/mysqld/
RUN chmod -R 755 /var/run/mysqld/
RUN chown mysql:mysql /var/lib/mysql/
RUN chmod -R 755 /var/lib/mysql/

EXPOSE 3306

COPY ./tools/create_db.sh ./
RUN chmod +x ./create_db.sh

ENTRYPOINT ["bash", "create_db.sh"]
