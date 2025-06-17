<?php
include 'conexao.php';

// Excluir cliente
if (isset($_GET['excluir'])) {
    $idExcluir = intval($_GET['excluir']);
    $conn->query("DELETE FROM clientes WHERE id = $idExcluir");
    header('Location: clientes.php');
    exit;
}

// Inserir novo cliente
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $nome = $_POST['nome'];
    $email = $_POST['email'];
    $endereco = $_POST['endereco'];

    $sql = "INSERT INTO clientes (nome, email, endereco) VALUES ('$nome', '$email', '$endereco')";
    if ($conn->query($sql) === TRUE) {
        header('Location: clientes.php?sucesso=1');
        exit;
    } else {
        $erro = $conn->error;
    }
}
?>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8" />
    <title>Cadastro de Clientes</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="bg-light">
<div class="container py-5">
    <h1 class="text-center">Cadastro de Clientes</h1>

    <?php
    if (isset($_GET['sucesso'])) {
        echo "<div class='alert alert-success'>Cliente adicionado com sucesso!</div>";
    }
    if (isset($erro)) {
        echo "<div class='alert alert-danger'>Erro: $erro</div>";
    }

    //$result = $conn->query("SELECT * FROM clientes ORDER BY id ASC");
    ?>

    <form method="POST" class="mb-4">
        <div class="mb-3">
            <label for="nome" class="form-label">Nome Completo:</label>
            <input type="text" class="form-control" id="nome" name="nome" required>
        </div>
        <div class="mb-3">
            <label for="email" class="form-label">Email Principal:</label>
            <input type="email" class="form-control" id="email" name="email" required>
        </div>
        <div class="mb-3">
            <label for="endereco" class="form-label">Endereço:</label>
            <input type="text" class="form-control" id="endereco" name="endereco" required>
        </div>
        <button type="submit" class="btn btn-primary">Salvar</button>
        <a href="index.php" class="btn btn-secondary ms-2">Voltar</a>
    </form>

    <h3>Clientes Cadastrados:</h3>
    <table class="table table-striped table-hover">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Nome</th>
                <th>Email</th>
                <th>Endereço</th>
                <th>Ações</th>
            </tr>
        </thead>
        <tbody>
        <?php while ($row = $result->fetch_assoc()): ?>
            <tr>
                <td><?= $row['id'] ?></td>
                <td><?= htmlspecialchars($row['nome']) ?></td>
                <td><?= htmlspecialchars($row['email']) ?></td>
                <td><?= htmlspecialchars($row['endereco']) ?></td>
                <td>
                    <a href="clientes.php?excluir=<?= $row['id'] ?>" 
                       class="btn btn-danger btn-sm" 
                       onclick="return confirm('Tem certeza que deseja excluir?')">
                       Excluir
                    </a>
                </td>
            </tr>
        <?php endwhile; ?>
        </tbody>
    </table>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

<?php $conn->close(); ?>
