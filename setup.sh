#!/bin/bash

# Переменные для настройки базы данных
DB_NAME="web"
DB_USER="api_user"
DB_PASSWORD='12345'
DB_FILE="bd/BD.sql"

echo "Генерация пароля для пользователя базы данных: $DB_PASSWORD"

if ! command -v psql &> /dev/null; then
    echo "PostgreSQL не установлен. Установите его и запустите скрипт снова."
    
    exit 1
fi
#DROP DATABASE $DB_NAME;
#DROP USER $DB_USER;
echo "Создание базы данных и пользователя..."
sudo -u postgres psql <<EOF
CREATE DATABASE $DB_NAME;
CREATE USER $DB_USER WITH PASSWORD '$DB_PASSWORD';
GRANT ALL PRIVILEGES ON DATABASE $DB_NAME TO $DB_USER;
EOF

if [ $? -ne 0 ]; then
    echo "Ошибка при создании базы данных или пользователя."
    exit 1
fi

echo "База данных $DB_NAME и пользователь $DB_USER созданы успешно."

if [ -f "$DB_FILE" ]; then
    echo "Импорт данных из $DB_FILE..."
    PGPASSWORD=$DB_PASSWORD psql -U $DB_USER -d $DB_NAME -h localhost -f $DB_FILE
    if [ $? -ne 0 ]; then
        echo "Ошибка при импорте данных."
        exit 1
    fi
    echo "Данные успешно импортированы."
else
    echo "Файл $DB_FILE не найден. Пропуск импорта."
fi

echo "Запуск Nginx..."

CURRENT_DIR=$(pwd)
sed -i "s|/path/to/web-project|$CURRENT_DIR|g" "nginx/server.conf"
cp nginx/server.conf /etc/nginx/sites-available/
ln -s /etc/nginx/sites-available/server.conf /etc/nginx/sites-enabled/
sudo systemctl restart nginx



echo "Запуск API..."

#python3 -m venv venv
#source venv/bin/activate
#pip install -r requirements.txt
uvicorn api.API:app --host 0.0.0.0 --port 3000


echo "Проект успешно запущен."
echo "Данные для подключения к БД:"
echo "  Имя БД: $DB_NAME"
echo "  Пользователь: $DB_USER"
echo "  Пароль: $DB_PASSWORD"
