
CREATE DATABASE IF NOT EXISTS oficina;
USE oficina;

CREATE TABLE Cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20),
    tipo_cliente ENUM('PF', 'PJ') NOT NULL
);

CREATE TABLE Veiculo (
    id_veiculo INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    modelo VARCHAR(100) NOT NULL,
    placa VARCHAR(10) UNIQUE NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

CREATE TABLE Ordem_Servico (
    id_ordem INT AUTO_INCREMENT PRIMARY KEY,
    id_veiculo INT NOT NULL,
    data_inicio DATE NOT NULL,
    status ENUM('Aberta', 'Em Andamento', 'Finalizada') NOT NULL,
    valor_total DECIMAL(10, 2),
    FOREIGN KEY (id_veiculo) REFERENCES Veiculo(id_veiculo)
);

CREATE TABLE Servico (
    id_servico INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(200) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Ordem_Servico_Servico (
    id_ordem INT,
    id_servico INT,
    PRIMARY KEY (id_ordem, id_servico),
    FOREIGN KEY (id_ordem) REFERENCES Ordem_Servico(id_ordem),
    FOREIGN KEY (id_servico) REFERENCES Servico(id_servico)
);

CREATE TABLE Peca (
    id_peca INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    valor_unitario DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Ordem_Servico_Peca (
    id_ordem INT,
    id_peca INT,
    quantidade INT NOT NULL,
    PRIMARY KEY (id_ordem, id_peca),
    FOREIGN KEY (id_ordem) REFERENCES Ordem_Servico(id_ordem),
    FOREIGN KEY (id_peca) REFERENCES Peca(id_peca)
);

CREATE TABLE Mecanico (
    id_mecanico INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    especialidade VARCHAR(100)
);

CREATE TABLE Mecanico_Ordem (
    id_mecanico INT,
    id_ordem INT,
    PRIMARY KEY (id_mecanico, id_ordem),
    FOREIGN KEY (id_mecanico) REFERENCES Mecanico(id_mecanico),
    FOREIGN KEY (id_ordem) REFERENCES Ordem_Servico(id_ordem)
);

-- Inserção de Clientes
INSERT INTO Cliente (nome, telefone, tipo_cliente) VALUES
('João Silva', '11999999999', 'PF'),
('Empresa Alpha LTDA', '1122223333', 'PJ'),
('Maria Oliveira', '11988887777', 'PF');

-- Inserção de Veículos
INSERT INTO Veiculo (id_cliente, modelo, placa) VALUES
(1, 'Fiat Uno', 'ABC1234'),
(2, 'Caminhão VW', 'XYZ9876'),
(3, 'Honda Civic', 'DEF5678');

-- Inserção de Mecânicos
INSERT INTO Mecanico (nome, especialidade) VALUES
('Carlos Mendes', 'Motor'),
('Roberto Lima', 'Freios'),
('Ana Souza', 'Elétrica');

-- Inserção de Serviços
INSERT INTO Servico (descricao, preco) VALUES
('Troca de óleo', 100.00),
('Revisão de freios', 150.00),
('Alinhamento', 80.00);

-- Inserção de Peças
INSERT INTO Peca (nome, valor_unitario) VALUES
('Pastilha de freio', 50.00),
('Filtro de óleo', 30.00),
('Correia dentada', 120.00);

-- Inserção de Ordens de Serviço
INSERT INTO Ordem_Servico (id_veiculo, data_inicio, status, valor_total) VALUES
(1, '2025-07-01', 'Finalizada', 280.00),
(2, '2025-07-05', 'Em Andamento', 200.00);

-- Associação Ordem e Serviços
INSERT INTO Ordem_Servico_Servico (id_ordem, id_servico) VALUES
(1, 1),
(1, 3),
(2, 2);

-- Associação Ordem e Peças
INSERT INTO Ordem_Servico_Peca (id_ordem, id_peca, quantidade) VALUES
(1, 1, 2),
(1, 2, 1),
(2, 3, 1);

-- Associação Mecanico e Ordem
INSERT INTO Mecanico_Ordem (id_mecanico, id_ordem) VALUES
(1, 1),
(2, 1),
(3, 2);

-- 1. Quantos veículos cada cliente possui?
SELECT c.nome AS cliente, COUNT(v.id_veiculo) AS quantidade_veiculos
FROM Cliente c
JOIN Veiculo v ON c.id_cliente = v.id_cliente
GROUP BY c.id_cliente;

-- 2. Quais ordens de serviço foram realizadas e os respectivos valores?
SELECT o.id_ordem, v.modelo, o.data_inicio, o.status, o.valor_total
FROM Ordem_Servico o
JOIN Veiculo v ON o.id_veiculo = v.id_veiculo;

-- 3. Valor total de peças por ordem (atributo derivado)
SELECT o.id_ordem, SUM(p.valor_unitario * op.quantidade) AS total_pecas
FROM Ordem_Servico o
JOIN Ordem_Servico_Peca op ON o.id_ordem = op.id_ordem
JOIN Peca p ON op.id_peca = p.id_peca
GROUP BY o.id_ordem;

-- 4. Ordens com mais de 1 serviço (HAVING)
SELECT oss.id_ordem, COUNT(*) AS total_servicos
FROM Ordem_Servico_Servico oss
GROUP BY oss.id_ordem
HAVING COUNT(*) > 1;

-- 5. Lista de mecânicos e ordens que trabalharam (JOIN múltiplo)
SELECT m.nome AS mecanico, o.id_ordem, v.modelo AS veiculo
FROM Mecanico m
JOIN Mecanico_Ordem mo ON m.id_mecanico = mo.id_mecanico
JOIN Ordem_Servico o ON mo.id_ordem = o.id_ordem
JOIN Veiculo v ON o.id_veiculo = v.id_veiculo
ORDER BY m.nome;



