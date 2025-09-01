<?php
require_once 'models/Database.php';
$db = new Database();
$pdo = $db->connect();
echo "✅ Подключено к БД";