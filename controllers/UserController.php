<?php
class UserController {
    private $dataFile = __DIR__ . '/../data/users.json';

    // Получить всех пользователей
    public function getAll() {
        $data = file_get_contents($this->dataFile);
        header('Content-Type: application/json');
        echo $data;
    }

    // Получить одного пользователя по ID
    public function getById($id) {
        $data = json_decode(file_get_contents($this->dataFile), true);
        $user = null;

        foreach ($data as $item) {
            if ($item['id'] == $id) {
                $user = $item;
                break;
            }
        }

        header('Content-Type: application/json');
        if ($user) {
            echo json_encode($user);
        } else {
            http_response_code(404);
            echo json_encode(['error' => 'Benutzer nicht gefunden']);
        }
    }

    // Создать нового пользователя
    public function create() {
        $input = json_decode(file_get_contents('php://input'), true);

        if (empty($input['name']) || empty($input['email'])) {
            http_response_code(400);
            echo json_encode(['error' => 'Name und E-Mail sind erforderlich']);
            return;
        }

        $data = json_decode(file_get_contents($this->dataFile), true);
        $newId = count($data) > 0 ? max(array_column($data, 'id')) + 1 : 1;

        $newUser = [
            'id' => $newId,
            'name' => $input['name'],
            'email' => $input['email']
        ];

        $data[] = $newUser;
        file_put_contents($this->dataFile, json_encode($data, JSON_PRETTY_PRINT));

        header('Content-Type: application/json');
        http_response_code(201);
        echo json_encode($newUser);
    }

    // Обновить пользователя по ID (PUT)
    public function update($id) {
    $input = json_decode(file_get_contents('php://input'), true);

    if (empty($input['name']) || empty($input['email'])) {
        http_response_code(400);
        echo json_encode(['error' => 'Name und E-Mail sind erforderlich']);
        return;
    }

    $data = json_decode(file_get_contents($this->dataFile), true);
    $found = false;
    $updatedUser = null;

    foreach ($data as &$item) {
        if ($item['id'] == $id) {
            $item['name'] = $input['name'];
            $item['email'] = $input['email'];
            $found = true;
            $updatedUser = $item; // Сохраняем копию обновлённого пользователя
        }
    }

    if (!$found) {
        http_response_code(404);
        echo json_encode(['error' => 'Benutzer nicht gefunden']);
        return;
    }

    file_put_contents($this->dataFile, json_encode($data, JSON_PRETTY_PRINT));

    header('Content-Type: application/json');
    echo json_encode(['message' => 'Benutzer aktualisiert', 'user' => $updatedUser]);
}
}