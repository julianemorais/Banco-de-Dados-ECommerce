create database ECommerce;
use ECommerce;

-- Criando Tabelas

CREATE TABLE ClientePJ (
    CNPJ VARCHAR(14) PRIMARY KEY,
    Razao_Social VARCHAR(50),
    Endereco VARCHAR(100),
    Telefone VARCHAR(15),
    Email VARCHAR(20),
    Contato VARCHAR(50),
    Periodo_de_carencia INT
);

CREATE TABLE Pedido (
    Codigo_Pedido INT AUTO_INCREMENT PRIMARY KEY,
    Data_Pedido DATE,
    Endereco_de_entrega VARCHAR(100),
    CPF VARCHAR(11),
    CNPJ VARCHAR(14),
    FOREIGN KEY (CPF) REFERENCES ClientePF(CPF),
    FOREIGN KEY (CNPJ) REFERENCES ClientePJ(CNPJ)
);

CREATE TABLE Entrega (
    Codigo_Pedido INT PRIMARY KEY,
    Status VARCHAR(15),
    Codigo_de_rastreio VARCHAR(30),
    FOREIGN KEY (Codigo_Pedido) REFERENCES Pedido(Codigo_Pedido)
);

CREATE TABLE Produto (
    IDProduto INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100),
    Descricao TEXT,
    Preco DECIMAL(10, 2),
    Quantidade INT
);

CREATE TABLE Fornecedor (
    IDFornecedor INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100),
    Contato VARCHAR(100)
);

CREATE TABLE Produto_Fornecedor (
    IDProduto INT,
    IDFornecedor INT,
    PRIMARY KEY (IDProduto, IDFornecedor),
    FOREIGN KEY (IDProduto) REFERENCES Produto(IDProduto),
    FOREIGN KEY (IDFornecedor) REFERENCES Fornecedor(IDFornecedor)
);

CREATE TABLE Pedido_Produto (
    Codigo_Pedido INT,
    IDProduto INT,
    PRIMARY KEY (Codigo_Pedido, IDProduto),
    FOREIGN KEY (Codigo_Pedido) REFERENCES Pedido(Codigo_Pedido),
    FOREIGN KEY (IDProduto) REFERENCES Produto(IDProduto)
);

CREATE TABLE Pagamento (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Tipo VARCHAR(50),
    Detalhes TEXT,
    Codigo_Pedido INT,
    FOREIGN KEY (Codigo_Pedido) REFERENCES Pedido(Codigo_Pedido)
);

ALTER TABLE Produto
ADD CONSTRAINT unique_nome UNIQUE (Nome);

ALTER TABLE ClientePF
ADD CONSTRAINT unique_nome UNIQUE (Nome);

ALTER TABLE ClientePJ
ADD CONSTRAINT unique_razao_social UNIQUE (Razao_Social);

-- Inserindo dados

insert into ClientePF (CPF, Nome, Endereco, Telefone, Email) values
('25625458998', 'Maria de Jesus Santos', 'Rua A, 45 - Bairro: 1', '5246862', 'maria@d.com'),
('25647825623', 'José Santos Silva', 'Rua B, 585 - Bairro: 2', '5478-2554', 'josesantos@abc.com'),
('45687952412', 'João Almeida', 'Rua 123, 52 - Bairro: qualquer', '546-5887', 'joao.a@cba.com'),
('85456247896', 'Rita Assis Cruz', 'Rua bc, 86 - Bairro: qwert', '5278-5263', 'rita.assis@gb.com'),
('56321474585', 'Moises da Silva', 'Rua mn, 48 - Bairro: fgt', '5896-2565', 'moises.silva@tr.com');

insert into ClientePJ (CNPJ, Razao_social, Endereco, Telefone, Contato, Email) values
('54786325691245', 'Dell', 'Rua da Dell, 58 Bairro: B', '5269-5854', 'Isabel Moreira', 'isabel.m@dell.com'),
('28565425889552', 'HP', 'Rua da HP, 85 Bairro: A', '5589-5524', 'Bárbara Santos', 'barbara.s@hp.com'),
('56365458785531', 'AOC', 'Rua da AOC, 564 Bairro: C', '2569-8554', 'Israel Oliveira', 'israel.o@daoc.com'), 
('35478963214525', 'Epson', 'Rua da Epson, 658 Bairro: D', '5247-8554', 'Rodrigo Souza', 'rodrigo.s@epson.com');

insert into Produto (Nome, Descricao, Preco, Quantidade) values 
('Notebook Latitude Dell', 'Notebook I5, 8GB de Memória, SSD 256GB, 15 polegadas', 4599.00, 100),
('Impressora 3776 HP', 'Impressora jato de tinta', 399.00, 250),
('Monitor AOC 22"', 'Monitor com 22 polegadas,', 859.99, 320);


INSERT INTO Pedido (Data_Pedido, Endereco_de_entrega, CPF, CNPJ, Periodo_de_carencia) VALUES
('2023-02-20', 'Rua A, 123', '25625458998', null, 30),
('2023-02-21', 'Rua B, 456', null, '54786325691245', 60);


insert into Fornecedor (Nome, Contato) values
('Dell', 'Orlando Araujo'),
('HP', 'Fabio Maranhão'),
('AOC', 'Cristina Silva'),
('Epson', 'Maria Santos');

ALTER TABLE ClientePF
DROP COLUMN Periodo_de_carencia;

ALTER TABLE ClientePJ
DROP COLUMN Periodo_de_carencia;

ALTER TABLE Pedido
ADD COLUMN Periodo_de_carencia INT;

desc Pedido;

UPDATE ClientePJ
SET Razao_Social = 'Empresa A', Email = 'isabel.m@empa.com', Endereco = 'Rua A1, 58 Bairro: B'
WHERE CNPJ = '54786325691245';

UPDATE ClientePJ
SET Razao_Social = 'Empresa B', Email = 'barbara.s@empb.com', Endereco = 'Rua B1, 85 Bairro: A'
WHERE CNPJ = '28565425889552';

UPDATE ClientePJ
SET Razao_Social = 'Empresa C', Email = 'israel.o@empc.com', Endereco = 'Rua C1, 564 Bairro: F'
WHERE CNPJ = '56365458785531';

UPDATE ClientePJ
SET Razao_Social = 'Empresa D', Email = 'rodrigo.s@empd.com', Endereco = 'Rua D1, 658 Bairro: E'
WHERE CNPJ = '35478963214525';

select * from ClientePJ;

select * from Pedido;

desc pagamento;

insert into Pagamento (Tipo, Detalhes, Codigo_Pedido) values
('Cartão Crédito', 'Pagamento em 10X', 1),
('PIX', 'Pagamento a vista', 2);

select * from Pagamento;

SELECT * FROM ClientePF;

select * from Produto where Codigo_pedido = 1;

select * from ClientePF order by Nome asc;


SELECT 
    pf.IDProduto, 
    pf.IDFornecedor, 
    pp.Codigo_Pedido
FROM 
    Produto_Fornecedor pf
INNER JOIN 
    Pedido_Produto pp ON pf.IDProduto = pp.IDProduto;
    
SELECT COUNT(*) AS total_pedidos
FROM Pedido;

SELECT CPF, COUNT(*) AS total_pedidos
FROM Pedido
GROUP BY CPF
HAVING COUNT(*) > 1;

-- Quantos pedidos foram feitos por cada cliente?

SELECT CPF AS Cliente, COUNT(*) AS total_pedidos
FROM Pedido
WHERE CPF IS NOT NULL
GROUP BY CPF

UNION

SELECT CNPJ AS Cliente, COUNT(*) AS total_pedidos
FROM Pedido
WHERE CNPJ IS NOT NULL
GROUP BY CNPJ;

-- Relação de nomes dos fornecedores e nomes dos produtos;

SELECT f.Nome AS Nome_Fornecedor, p.Nome AS Nome_Produto
FROM Produto p
INNER JOIN Produto_Fornecedor pf ON p.IDProduto = pf.IDProduto
INNER JOIN Fornecedor f ON pf.IDFornecedor = f.IDFornecedor;

