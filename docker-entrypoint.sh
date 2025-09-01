#!/bin/bash

# Путь к файлу
USERS_FILE="/var/www/html/data/users.json"

# Создаём папку data, если её нет
mkdir -p /var/www/html/data

# Если файла users.json нет — создаём его с начальными данными
if [ ! -f "$USERS_FILE" ]; then
    echo "Creating initial users.json..."
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

# Меняем владельца на www-data (чтобы Apache мог читать/писать)
chown -R www-data:www-data /var/www/html/data
chmod -R 755 /var/www/html/data

# Запускаем оригинальную команду (apache2-foreground)
exec "$@"