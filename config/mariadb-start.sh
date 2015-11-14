#!/bin/bash

# if the /data/mariadb directory doesn't contain anything, then initialise it
directory="/data/mariadb/data"
if [ ! "$(ls -A $directory)" ]; then
    /usr/bin/mysql_install_db --datadir=/data/mariadb/data --user=mysql
    cp /opt/bin/mariadb-setup.sql /tmp/combined.sql
    cat >> /tmp/combined.sql <<-EOSQL
	CREATE USER '${LARAVEL_DB_USER}'@'%' IDENTIFIED BY PASSWORD('${LARAVEL_DB_PASS}');
	CREATE DATABASE '${LARAVEL_DB_NAME}';
	GRANT ALL PRIVILEGES ON \`${LARAVEL_DB_NAME}\`.* To '${LARAVEL_DB_USER}'@'%' IDENTIFIED BY '${LARAVEL_DB_PASS}';
	FLUSH PRIVILEGES;
	CONNECT '${LARAVEL_DB_NAME}';
EOSQL
    cat /data/testdata.sql >> /tmp/combined.sql
    /usr/bin/mysqld_safe --init-file=/tmp/combined.sql
else
    /usr/bin/mysqld_safe
fi
