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
