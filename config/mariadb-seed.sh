#!/bin/bash

mysql -u "${LARAVEL_DB_USER}" --password="${LARAVEL_DB_PASS}" "${LARAVEL_DB_NAME}" -h "${DB_PORT_3306_TCP_ADDR}" < /data/testdata.sql
