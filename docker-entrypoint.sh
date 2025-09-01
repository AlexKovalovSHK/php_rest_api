#!/bin/bash

USERS_FILE="/var/www/html/data/users.json"
mkdir -p /var/www/html/data

if [ ! -f "$USERS_FILE" ]; then
    echo "🔧 Creating initial users.json..."
    cat > "$USERS_FILE" << 'EOF'
[
    {
        "id": 1,
        "name": "Anna",
        "email": "anna@example.com"
    },
    {
        "id": 2,
        "name": "Boris",
        "email": "boris@example.com"
    },
    {
        "id": 3,
        "name": "Viktor",
        "email": "viktor@example.com"
    }
]
EOF
fi

# 🔥 Устанавливаем владельца и права
chown -R www-www-data /var/www/html/data
chmod -R 755 /var/www/html/data

exec "$@"