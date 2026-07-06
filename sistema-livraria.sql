-- Apaga as tabelas caso elas já existam
DROP TABLE IF EXISTS Compras;
DROP TABLE IF EXISTS Clientes;

-- Criação da Tabela Clientes
CREATE TABLE Clientes (
    ID INTEGER PRIMARY KEY,
    nomeCliente VARCHAR(100),
    emailCliente VARCHAR(100)
);

-- Criação da Tabela Compras
CREATE TABLE Compras (
    CompraID INTEGER PRIMARY KEY,
    ClienteID INTEGER,
    NomeLivro VARCHAR(150),
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ID)
);

SELECT * FROM Clientes; 
-- 1. Limpeza do banco de dados (evita o erro de tabela já existente)
DROP TABLE IF EXISTS Compras;
DROP TABLE IF EXISTS Clientes;

-- 2. Criação da Tabela Clientes
CREATE TABLE Clientes (
    ID INTEGER PRIMARY KEY,
    nomeCliente VARCHAR(100),
    emailCliente VARCHAR(100)
);

-- 3. Criação da Tabela Compras
CREATE TABLE Compras (
    CompraID INTEGER PRIMARY KEY,
    ClienteID INTEGER,
    NomeLivro VARCHAR(150),
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ID)
);

-- 4. Inserção de Dados na Tabela Clientes
INSERT INTO Clientes (ID, nomeCliente, emailCliente) VALUES 
(1, 'Carlos Eduardo', 'carlos.edu@email.com'),
(2, 'Ana Beatriz', 'ana.bia@email.com'),
(3, 'Mariana Costa', 'mari.costa@email.com'),
(4, 'Rodrigo Santos', 'rodrigo.s@email.com'),
(5, 'Beatriz Oliveira', 'bia.oliveira@email.com');

-- 5. Inserção de Dados na Tabela Compras
-- (Note que os clientes 1 e 3 compraram o livro "Quarto de Despejo")
INSERT INTO Compras (CompraID, ClienteID, NomeLivro) VALUES 
(101, 1, 'Quarto de Despejo'),
(102, 2, 'Dom Casmurro'),
(103, 3, 'Quarto de Despejo'),
(104, 4, 'O Alienista'),
(105, 5, 'Memórias Póstumas de Brás Cubas');
SELECT * FROM Clientes; 
SELECT * FROM Compras; 
