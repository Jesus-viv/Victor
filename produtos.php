<?php
require 'conexao.php';

// Inserir novo produto
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['nome'], $_POST['preco'])) {
    $nome = $conn->real_escape_string($_POST['nome']);
    $preco = floatval($_POST['preco']);
    $conn->query("INSERT INTO produtos (nome, preco) VALUES ('$nome', $preco)");

    // Redireciona para evitar reenvio ao atualizar a página
    header('Location: produtos.php');
    exit;
}


// Excluir produto
if (isset($_GET['excluir'])) {
    $idExcluir = intval($_GET['excluir']);
    $conn->query("DELETE FROM produtos WHERE id = $idExcluir");
    header('Location: produtos.php');
    exit;
}
?>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8" />
    <title>Produtos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="bg-light">
<div class="container py-5">
    <h2 class="text-center">Produtos</h2>

    <table class="table table-striped table-hover">
        <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Nome</th>
            <th>Preço (R$)</th>
            <th>Ações</th>
        </tr>
        </thead>
        <tbody>
        <?php
        $result = $conn->query("SELECT * FROM produtos ORDER BY id ASC");
        while ($row = $result->fetch_assoc()) {
            echo "<tr>
                    <td>{$row['id']}</td>
                    <td>".htmlspecialchars($row['nome'])."</td>
                    <td>R$ ".number_format($row['preco'], 2, ',', '.')."</td>
                    <td>
                        <a href='produtos.php?excluir={$row['id']}' class='btn btn-danger btn-sm' onclick='return confirm(\"Tem certeza que deseja excluir?\")'>Excluir</a>
                    </td>
                  </tr>";
        
        }
        ?>
        </tbody>
    </table>

    <h4>Adicionar Novo Produto</h4>
    <form method="POST" class="mb-3">
        <div class="mb-3">
            <label for="nome" class="form-label">Nome do Produto</label>
            <input type="text" id="nome" name="nome" class="form-control" required />
        </div>
        <div class="mb-3">
            <label for="preco" class="form-label">Preço (R$)</label>
            <input type="number" step="0.01" min="0" id="preco" name="preco" class="form-control" required />
        </div>
        <button type="submit" class="btn btn-primary">Adicionar Produto</button>
        <a href="index.php" class="btn btn-secondary ms-2">Voltar</a>
    </form>
</div>
</body>
</html>
