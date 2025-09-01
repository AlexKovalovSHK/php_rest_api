#!/bin/bash

USERS_FILE="/var/www/html/data/users.json"
mkdir -p /var/www/html/data

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

chown -R www-www-data /var/www/html/data
chmod -R 755 /var/www/html/data

exec "$@"