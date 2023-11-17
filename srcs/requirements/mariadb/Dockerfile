FROM debian:bullseye AS mariadb_installation

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
#RUN groupadd -r mysql && useradd -r -g mysql mysql --home-dir /var/lib/mysql

#ARG REPOSITORY="http://archive.mariadb.org/mariadb-10.5.23/repo/debian/ focal main main/debug"

#RUN set -e;\
#	echo "deb ${REPOSITORY}" > /etc/apt/sources.list.d/mariadb.list; \
#	{ \
#		echo 'Package: *'; \
#		echo 'Pin: release o=MariaDB'; \
#		echo 'Pin-Priority: 999'; \
#	} > /etc/apt/preferences.d/mariadb

#ARG MARIADB_VERSION=1:10.5.23+maria~ubu2004


RUN apt-get update -y \
	&& apt-get -y install apt-transport-https curl

RUN mkdir -p /etc/apt/keyrings
RUN curl -o /etc/apt/keyrings/mariadb-keyring.pgp 'https://mariadb.org/mariadb_release_signing_key.pgp'


RUN apt-get update -y \
    &&  apt-get -y install \
	    procps \
            mariadb-server mariadb-client \
    &&  rm -rf /var/lib/apt/lists/*
#		--no-install-recommends mariadb-server="$MARIADB_VERSION"

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
