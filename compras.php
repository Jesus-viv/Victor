<?php
require 'conexao.php';

// Inserir nova compra
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['id_cliente'], $_POST['id_produto'], $_POST['quantidade'])) {
    $id_cliente = intval($_POST['id_cliente']);
    $id_produto = intval($_POST['id_produto']);
    $quantidade = intval($_POST['quantidade']);
    if ($quantidade > 0) {
        $conn->query("INSERT INTO compras (id_cliente, id_produto, quantidade) VALUES ($id_cliente, $id_produto, $quantidade)");
    }
}

// Excluir compra
if (isset($_GET['excluir'])) {
    $idExcluir = intval($_GET['excluir']);
    $conn->query("DELETE FROM compras WHERE id = $idExcluir");
    header('Location: compras.php');
    exit;
}

?>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8" />
    <title>Compras</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="bg-light">
<div class="container py-5">
  <h1 class="text-center">Compras</h1>

    <table class="table table-striped table-hover">
        <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Cliente</th>
            <th>Produto</th>
            <th>Quantidade</th>
            <th>Ações</th>
        </tr>
        </thead>
        <tbody>
        <?php
        $sql = "SELECT compras.id, clientes.nome AS cliente, produtos.nome AS produto, compras.quantidade
                FROM compras
                JOIN clientes ON compras.id_cliente = clientes.id
                JOIN produtos ON compras.id_produto = produtos.id
                ORDER BY compras.id DESC";
        $result = $conn->query($sql);
        while ($row = $result->fetch_assoc()) {
            echo "<tr>
                    <td>{$row['id']}</td>
                    <td>".htmlspecialchars($row['cliente'])."</td>
                    <td>".htmlspecialchars($row['produto'])."</td>
                    <td>{$row['quantidade']}</td>
                    <td>
                        <a href='compras.php?excluir={$row['id']}' class='btn btn-danger btn-sm' onclick='return confirm(\"Tem certeza que deseja excluir?\")'>Excluir</a>
                    </td>
                  </tr>";
        }
        ?>
        </tbody>
    </table>

    <h4>Registrar Nova Compra</h4>
    <form method="POST" class="mb-3">
        <div class="mb-3">
            <label for="id_cliente" class="form-label">Cliente</label>
            <select id="id_cliente" name="id_cliente" class="form-select" required>
                <option value="">Selecione um cliente</option>
                <?php
                $clientes = $conn->query("SELECT * FROM clientes ORDER BY nome");
                while ($row = $clientes->fetch_assoc()) {
                    echo "<option value='{$row['id']}'>".htmlspecialchars($row['nome'])."</option>";
                }
                ?>
            </select>
        </div>
        <div class="mb-3">
            <label for="id_produto" class="form-label">Produto</label>
            <select id="id_produto" name="id_produto" class="form-select" required>
                <option value="">Selecione um produto</option>
                <?php
                $produtos = $conn->query("SELECT * FROM produtos ORDER BY nome");
                while ($row = $produtos->fetch_assoc()) {
                    echo "<option value='{$row['id']}'>".htmlspecialchars($row['nome'])."</option>";
                }
                ?>
            </select>
        </div>
        <div class="mb-3">
            <label for="quantidade" class="form-label">Quantidade</label>
            <input type="number" id="quantidade" name="quantidade" class="form-control" min="1" required />
            
        </div>
        <button type="submit" class="btn btn-primary">Registrar Compra</button>
        <a href="index.php" class="btn btn-secondary ms-2">Voltar</a>
    </form>
</div>
</body>
</html>
