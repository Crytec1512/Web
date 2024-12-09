#!/bin/bash

# Переменные для настройки базы данных
DB_NAME="web"
DB_USER="api_user"
DB_PASSWORD=$(openssl rand -base64 12) # Генерация случайного пароля
DB_FILE="bd/BD.sql"

echo "Генерация пароля для пользователя базы данных: $DB_PASSWORD"

# Убедимся, что PostgreSQL установлен
if ! command -v psql &> /dev/null; then
    echo "PostgreSQL не установлен. Установите его и запустите скрипт снова."
    
    exit 1
fi

# Создание базы данных и пользователя
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

# Импорт данных из BD.sql
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

# Запуск Nginx (если требуется)
echo "Запуск Nginx..."

cp nginx/server.conf /etc/nginx/sites-available/
ln -s /etc/nginx/sites-available/server.conf /etc/nginx/sites-enabled/
sudo systemctl restart nginx


# Запуск API (добавьте команду запуска вашего API)
echo "Запуск API..."
# Например:
# cd /path/to/api
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
uvicorn api.API:app --host 0.0.0.0 --port 3000


echo "Проект успешно запущен."
echo "Данные для подключения к БД:"
echo "  Имя БД: $DB_NAME"
echo "  Пользователь: $DB_USER"
echo "  Пароль: $DB_PASSWORD"
