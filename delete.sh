#!/bin/bash

DB_NAME="web"
DB_USER="api_user"
PG_SUPERUSER="postgres" 
PG_HOST="localhost"
PG_PORT="5432"

function run_psql {
    PGPASSWORD="$PG_SUPERUSER_PASSWORD" psql -U "$PG_SUPERUSER" -h "$PG_HOST" -p "$PG_PORT" -d postgres -c "$1"
}

if [ -z "$PG_SUPERUSER_PASSWORD" ]; then
    echo "Ошибка: Установите пароль суперпользователя PostgreSQL в переменной PG_SUPERUSER_PASSWORD."
    exit 1
fi

echo "Удаляем базу данных '$DB_NAME'..."
run_psql "DROP DATABASE IF EXISTS \"$DB_NAME\";"
if [ $? -eq 0 ]; then
    echo "База данных '$DB_NAME' успешно удалена."
else
    echo "Ошибка при удалении базы данных '$DB_NAME'."
fi


echo "Удаляем пользователя '$DB_USER'..."
run_psql "DROP ROLE IF EXISTS \"$DB_USER\";"
if [ $? -eq 0 ]; then
    echo "Пользователь '$DB_USER' успешно удалён."
else
    echo "Ошибка при удалении пользователя '$DB_USER'."
fi
