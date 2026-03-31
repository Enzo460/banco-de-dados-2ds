CREATE TABLE FARMACIA ( 
    CNPJ_farmacia BIGINT PRIMARY KEY,  -- CNPJ é um número muito grande para INT comum
    end_farmacia VARCHAR(255),         -- Endereço deve ser texto
    nome_farmacia VARCHAR(100),        -- Nome deve ser texto
    tel_farmacia VARCHAR(20)           -- Telefone é melhor como texto para incluir ddd e traços
); 

CREATE TABLE PRODUTO ( 
    cod_produto INT PRIMARY KEY,  
    valor_produto DECIMAL(10,2),       -- Valor monetário usa Decimal para centavos
    qtd_produto INT,  
    CNPJ_farmacia BIGINT               -- Deve ser o mesmo tipo e nome da chave em FARMACIA
); 

CREATE TABLE FARMACEUTICO ( 
    CPF_farmaceutico BIGINT PRIMARY KEY,  -- Nomes mais claros ajudam na organização
    nome_farmaceutico VARCHAR(100)
); 

CREATE TABLE trabalha ( 
    CPF_farmaceutico BIGINT,
    CNPJ_farmacia BIGINT,
    PRIMARY KEY (CPF_farmaceutico, CNPJ_farmacia) -- Chave composta para relação N:N
); 

-- Adicionando as chaves estrangeiras corretamente
ALTER TABLE PRODUTO ADD FOREIGN KEY(CNPJ_farmacia) REFERENCES FARMACIA (CNPJ_farmacia);

ALTER TABLE trabalha ADD FOREIGN KEY(CPF_farmaceutico) REFERENCES FARMACEUTICO (CPF_farmaceutico);
ALTER TABLE trabalha ADD FOREIGN KEY(CNPJ_farmacia) REFERENCES FARMACIA (CNPJ_farmacia);
