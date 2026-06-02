-- 1. Criação da tabela com campos obrigatórios e ID automático
CREATE TABLE Clientes (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Data_Cadastro DATE NOT NULL
);

-- 2. Inserção da 1ª linha (Ana Silva com a data atual do sistema)
INSERT INTO Clientes (Nome, Email, Data_Cadastro) 
VALUES ('Ana Silva', 'ana.silva@example.com', '2026-06-02');

-- 3. Inserção das linhas 2 e 3 em um único comando INSERT INTO
INSERT INTO Clientes (Nome, Email, Data_Cadastro) VALUES 
('Bruno Souza', 'bruno.souza@example.com', '2026-06-02'),
('Carla Mendes', 'carla.mendes@example.com', '2026-06-02');

select * from Clientes;
