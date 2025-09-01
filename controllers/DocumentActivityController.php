<?php
require_once __DIR__ . '/../models/Database.php';

class DocumentActivityController {
    private $pdo;

    public function __construct() {
        $db = new Database();
        $this->pdo = $db->connect();
    }

    // Получить все записи
    public function getAll() {
        try {
            $query = "SELECT * FROM document_activity ORDER BY created_at DESC";
            $stmt = $this->pdo->prepare($query);
            $stmt->execute();

            $activities = $stmt->fetchAll();

            header('Content-Type: application/json');
            echo json_encode([
                'success' => true,
                'data' => $activities,
                'count' => count($activities)
            ]);
        } catch (PDOException $e) {
            http_response_code(500);
            echo json_encode(['error' => 'Failed to fetch data', 'message' => $e->getMessage()]);
        }
    }
}