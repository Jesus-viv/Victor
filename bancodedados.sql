-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 17/06/2025 às 04:04
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `compras_duraveis`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `clientes`
--

CREATE TABLE `clientes` (
  `id` int(11) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `endereco` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `clientes`
--

INSERT INTO `clientes` (`id`, `nome`, `email`, `endereco`) VALUES
(4, 'Josué Cipriano', 'josuecipriano@hotmail.com', 'QR 403 Conjunto L casa 07'),
(5, 'Victor Okubo', 'victorokubo@gmail.com', 'Quadra 16 Conjunto A Setor Central'),
(10, 'Luiz Henrique', 'luizhenrique@gmail.com', 'QR 403 Conjunto L casa 07');

--
-- Acionadores `clientes`
--
DELIMITER $$
CREATE TRIGGER `after_delete_cliente` AFTER DELETE ON `clientes` FOR EACH ROW BEGIN
    INSERT INTO log_geral (tabela, acao, id_registro, detalhe)
    VALUES ('clientes', 'DELETE', OLD.id, CONCAT('Nome: ', OLD.nome, ', Email: ', OLD.email, ', Endereco: ', OLD.endereco));
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_insert_cliente` AFTER INSERT ON `clientes` FOR EACH ROW BEGIN
    INSERT INTO log_geral (tabela, acao, id_registro, detalhe)
    VALUES ('clientes', 'INSERT', NEW.id, CONCAT('Nome: ', NEW.nome, ', Email: ', NEW.email, ', Endereco: ', NEW.endereco));
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_update_cliente` AFTER UPDATE ON `clientes` FOR EACH ROW BEGIN
    INSERT INTO log_geral (tabela, acao, id_registro, detalhe)
    VALUES ('clientes', 'UPDATE', NEW.id, CONCAT('Nome: ', NEW.nome, ', Email: ', NEW.email, ', Endereco: ', NEW.endereco));
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `compras`
--

CREATE TABLE `compras` (
  `id` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `id_produto` int(11) NOT NULL,
  `quantidade` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `compras`
--

INSERT INTO `compras` (`id`, `id_cliente`, `id_produto`, `quantidade`) VALUES
(3, 4, 5, 2),
(4, 5, 6, 3);

--
-- Acionadores `compras`
--
DELIMITER $$
CREATE TRIGGER `after_delete_compra` AFTER DELETE ON `compras` FOR EACH ROW BEGIN
    INSERT INTO log_geral (tabela, acao, id_registro, detalhe)
    VALUES ('compras', 'DELETE', OLD.id, CONCAT('Cliente ID: ', OLD.id_cliente, ', Produto ID: ', OLD.id_produto, ', Quantidade: ', OLD.quantidade));
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_insert_compra` AFTER INSERT ON `compras` FOR EACH ROW BEGIN
    INSERT INTO log_geral (tabela, acao, id_registro, detalhe)
    VALUES ('compras', 'INSERT', NEW.id, CONCAT('Cliente ID: ', NEW.id_cliente, ', Produto ID: ', NEW.id_produto, ', Quantidade: ', NEW.quantidade));
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_update_compra` AFTER UPDATE ON `compras` FOR EACH ROW BEGIN
    INSERT INTO log_geral (tabela, acao, id_registro, detalhe)
    VALUES ('compras', 'UPDATE', NEW.id, CONCAT('Cliente ID: ', NEW.id_cliente, ', Produto ID: ', NEW.id_produto, ', Quantidade: ', NEW.quantidade));
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `log_compras`
--

CREATE TABLE `log_compras` (
  `id` int(11) NOT NULL,
  `acao` varchar(20) NOT NULL,
  `id_compra` int(11) DEFAULT NULL,
  `id_cliente` int(11) DEFAULT NULL,
  `id_produto` int(11) DEFAULT NULL,
  `quantidade` int(11) DEFAULT NULL,
  `data_log` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `log_geral`
--

CREATE TABLE `log_geral` (
  `id` int(11) NOT NULL,
  `tabela` varchar(50) NOT NULL,
  `acao` varchar(20) NOT NULL,
  `id_registro` int(11) DEFAULT NULL,
  `detalhe` text DEFAULT NULL,
  `data_log` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `log_geral`
--

INSERT INTO `log_geral` (`id`, `tabela`, `acao`, `id_registro`, `detalhe`, `data_log`) VALUES
(1, 'clientes', 'INSERT', 11, 'Nome: Bismarque Aquino, Email: bismarquevasco@gmail.com, Endereco: Condomínio Porto Rico Etapa 17c', '2025-06-14 04:45:11'),
(2, 'compras', 'INSERT', 6, 'Cliente ID: 11, Produto ID: 7, Quantidade: 2', '2025-06-14 04:46:10'),
(3, 'clientes', 'DELETE', 11, 'Nome: Bismarque Aquino, Email: bismarquevasco@gmail.com, Endereco: Condomínio Porto Rico Etapa 17c', '2025-06-14 04:47:02');

-- --------------------------------------------------------

--
-- Estrutura para tabela `produtos`
--

CREATE TABLE `produtos` (
  `id` int(11) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `preco` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `produtos`
--

INSERT INTO `produtos` (`id`, `nome`, `preco`) VALUES
(5, 'Geladeira BRASTEMP', 6500),
(6, 'Microondas', 880),
(7, 'PS5', 5000);

--
-- Acionadores `produtos`
--
DELIMITER $$
CREATE TRIGGER `after_delete_produto` AFTER DELETE ON `produtos` FOR EACH ROW BEGIN
    INSERT INTO log_geral (tabela, acao, id_registro, detalhe)
    VALUES ('produtos', 'DELETE', OLD.id, CONCAT('Nome: ', OLD.nome, ', Preco: ', OLD.preco));
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_insert_produto` AFTER INSERT ON `produtos` FOR EACH ROW BEGIN
    INSERT INTO log_geral (tabela, acao, id_registro, detalhe)
    VALUES ('produtos', 'INSERT', NEW.id, CONCAT('Nome: ', NEW.nome, ', Preco: ', NEW.preco));
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_update_produto` AFTER UPDATE ON `produtos` FOR EACH ROW BEGIN
    INSERT INTO log_geral (tabela, acao, id_registro, detalhe)
    VALUES ('produtos', 'UPDATE', NEW.id, CONCAT('Nome: ', NEW.nome, ', Preco: ', NEW.preco));
END
$$
DELIMITER ;

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `compras`
--
ALTER TABLE `compras`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_cliente` (`id_cliente`),
  ADD KEY `id_produto` (`id_produto`);

--
-- Índices de tabela `log_compras`
--
ALTER TABLE `log_compras`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `log_geral`
--
ALTER TABLE `log_geral`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `produtos`
--
ALTER TABLE `produtos`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de tabela `compras`
--
ALTER TABLE `compras`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de tabela `log_compras`
--
ALTER TABLE `log_compras`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `log_geral`
--
ALTER TABLE `log_geral`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `produtos`
--
ALTER TABLE `produtos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `compras`
--
ALTER TABLE `compras`
  ADD CONSTRAINT `compras_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `compras_ibfk_2` FOREIGN KEY (`id_produto`) REFERENCES `produtos` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

show triggers;
