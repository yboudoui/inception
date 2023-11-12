#!/bin/sh

#set -eux

if [ -d "/var/lib/mysql/${MYSQL_DATABASE}" ]
then 
	echo "Database already exists"
else

service mysql start;
sleep 10
service mysql status;
mysql -uroot -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
mysql -uroot -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mysql -uroot -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mysql -uroot -e "FLUSH PRIVILEGES;"
mysql -uroot -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"

mysqladmin -uroot -p${MYSQL_ROOT_PASSWORD} shutdown

fi

exec mysqld_safe
echo "MariaDB database and user were created successfully! "
