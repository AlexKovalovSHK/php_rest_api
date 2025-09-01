<?php
// Включаем обработку CORS, чтобы Postman мог отправлять запросы
header('Access-Control-Allow-Origin: *');
header('Content-Type: application/json');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

// Поддержка OPTIONS (для preflight-запросов)
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

require_once 'controllers/UserController.php';

$controller = new UserController();
$method = $_SERVER['REQUEST_METHOD'];
$path = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);

// Простой роутинг
// Пример: /api/users или /api/users/1
$parts = explode('/', trim($path, '/'));

if ($parts[0] === 'api' && $parts[1] === 'users') {
    if ($method === 'GET') {
        if (isset($parts[2]) && is_numeric($parts[2])) {
            $controller->getById((int)$parts[2]);
        } else {
            $controller->getAll();
        }
    } elseif ($method === 'POST') {
        $controller->create();
    } else {
        http_response_code(405);
        echo json_encode(['error' => 'Метод не поддерживается']);
    }
} else {
    http_response_code(404);
    echo json_encode(['error' => 'Маршрут не найден']);
}