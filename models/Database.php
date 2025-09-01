<?php
require_once __DIR__ . '/../vendor/autoload.php';

use Dotenv\Dotenv;

class Database {
    private $host;
    private $db;
    private $user;
    private $pass;
    private $port;
    private $pdo;

    public function __construct() {
        $dotenv = Dotenv::createImmutable(__DIR__ . '/..');
        $dotenv->load();

        $this->host = $_ENV['DB_HOST'];
        $this->db = $_ENV['DB_NAME'];
        $this->user = $_ENV['DB_USER'];
        $this->pass = $_ENV['DB_PASS'];
        $this->port = $_ENV['DB_PORT'] ?? 3306;
    }

    public function connect() {
        $this->pdo = null;
        try {
            $dsn = "mysql:host={$this->host};port={$this->port};dbname={$this->db};charset=utf8mb4";
            $this->pdo = new PDO($dsn, $this->user, $this->pass, [
                PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC
            ]);
        } catch (PDOException $e) {
            http_response_code(500);
            echo json_encode(['error' => 'DB connection failed', 'message' => $e->getMessage()]);
            exit();
        }
        return $this->pdo;
    }
}