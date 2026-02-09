
-- Tabela de Cursos
CREATE TABLE IF NOT EXISTS cursos (
    id_curso INT PRIMARY KEY,
    nome_curso VARCHAR(100) NOT NULL,
    descricao TEXT,
    carga_horaria INT NOT NULL,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de Alunos
CREATE TABLE IF NOT EXISTS alunos (
    id_aluno INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    data_nascimento DATE,
    cpf VARCHAR(11) UNIQUE NOT NULL,
    telefone VARCHAR(11),
    endereco VARCHAR(200),
    cidade VARCHAR(50),
    estado VARCHAR(2),
    cep VARCHAR(8),
    data_matricula DATE NOT NULL,
    id_curso INT NOT NULL,
    FOREIGN KEY (id_curso) REFERENCES cursos(id_curso)
);

-- Tabela de Professores
CREATE TABLE IF NOT EXISTS professores (
    id_professor INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    cpf VARCHAR(11) UNIQUE NOT NULL,
    telefone VARCHAR(11),
    especialidade VARCHAR(100),
    data_contratacao DATE NOT NULL,
    salario DECIMAL(10, 2),
    ativo BOOLEAN DEFAULT TRUE
);

-- Tabela de Disciplinas
CREATE TABLE IF NOT EXISTS disciplinas (
    id_disciplina INT PRIMARY KEY,
    nome_disciplina VARCHAR(100) NOT NULL,
    descricao TEXT,
    carga_horaria INT NOT NULL,
    id_curso INT NOT NULL,
    id_professor INT,
    FOREIGN KEY (id_curso) REFERENCES cursos(id_curso),
    FOREIGN KEY (id_professor) REFERENCES professores(id_professor)
);

-- Tabela de Notas
CREATE TABLE IF NOT EXISTS notas (
    id_nota INT PRIMARY KEY,
    id_aluno INT NOT NULL,
    id_disciplina INT NOT NULL,
    primeira_nota DECIMAL(5, 2),
    segunda_nota DECIMAL(5, 2),
    terceira_nota DECIMAL(5, 2),
    media_final DECIMAL(5, 2),
    situacao ENUM('Aprovado', 'Reprovado', 'Recuperacao') DEFAULT 'Recuperacao',
    data_lancamento TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_aluno) REFERENCES alunos(id_aluno),
    FOREIGN KEY (id_disciplina) REFERENCES disciplinas(id_disciplina)
);

-- Tabela de Frequência
CREATE TABLE IF NOT EXISTS frequencia (
    id_frequencia INT PRIMARY KEY,
    id_aluno INT NOT NULL,
    id_disciplina INT NOT NULL,
    data_aula DATE NOT NULL,
    presente BOOLEAN NOT NULL,
    FOREIGN KEY (id_aluno) REFERENCES alunos(id_aluno),
    FOREIGN KEY (id_disciplina) REFERENCES disciplinas(id_disciplina)
);

-- Tabela de Salas
CREATE TABLE IF NOT EXISTS salas (
    id_sala INT PRIMARY KEY,
    numero_sala VARCHAR(20) NOT NULL UNIQUE,
    capacidade INT NOT NULL,
    localizacao VARCHAR(100),
    equipamentos TEXT
);

-- Tabela de Horários
CREATE TABLE IF NOT EXISTS horarios (
    id_horario INT PRIMARY KEY,
    id_disciplina INT NOT NULL,
    id_sala INT NOT NULL,
    dia_semana ENUM('Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta') NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fim TIME NOT NULL,
    FOREIGN KEY (id_disciplina) REFERENCES disciplinas(id_disciplina),
    FOREIGN KEY (id_sala) REFERENCES salas(id_sala)
);