#!/bin/bash

# Путь к файлу данных
USERS_FILE="/var/www/html/data/users.json"

# Создаём папку, если её нет
mkdir -p /var/www/html/data

# Если файла нет — создаём с начальными данными
if [ ! -f "$USERS_FILE" ]; then
    echo "🔧 Creating initial users.json..."
    cat > "$USERS_FILE" << 'EOF'
[
    {
        "id": 1,
        "name": "Анна",
        "email": "anna@example.com"
    },
    {
        "id": 2,
        "name": "Борис",
        "email": "boris@example.com"
    },
    {
        "id": 3,
        "name": "Виктор",
        "email": "viktor@example.com"
    }
]
EOF
fi

# Права: Apache (www-data) должен иметь доступ
chown -R www-www-data /var/www/html/data
chmod -R 755 /var/www/html/data

# Запускаем основную команду (apache2-foreground)
exec "$@"