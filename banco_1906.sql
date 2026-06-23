-- Cria a tabela apenas se ela não existir
CREATE TABLE IF NOT EXISTS Clientes (
    id INTEGER PRIMARY KEY,
    nome VARCHAR(50),
    idade INT,
    cidade VARCHAR(50),
    status VARCHAR(20)
);

-- Limpa os dados antigos para evitar erro de ID duplicado
DELETE FROM Clientes;

-- Inserção de dados detalhando as colunas
INSERT INTO Clientes (id, nome, idade, cidade, status) VALUES
(1, 'Ana', 25, 'Curitiba', 'Ativo'),
(2, 'Bruno', 32, 'Londrina', 'Ativo'),
(3, 'Carla', 29, 'Maringá', 'Inativo'),
(4, 'Diego', 40, 'Curitiba', 'Ativo'),
(5, 'Elisa', 22, 'Maringá', 'Ativo');

-- Consulta dos dados inseridos
SELECT * FROM Clientes;

