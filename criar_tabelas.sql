-- formato de : yyyy-mm-dd
create database gerenciamentoEstoqueVenda;
use gerenciamentoEstoqueVenda;

CREATE TABLE IF NOT EXISTS usuario (
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE, 
    senha VARCHAR(20) NOT NULL
);


CREATE TABLE IF NOT EXISTS fornecedor (
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    rua VARCHAR(50) NOT NULL,
    cep VARCHAR(9) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    bairro VARCHAR(20) NOT NULL
    
    -- foreign key
    -- id_usuario INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
);


CREATE TABLE IF NOT EXISTS categoria(
	id INT AUTO_INCREMENT,
	descricao VARCHAR(15) NOT NULL UNIQUE,
    PRIMARY KEY(id_categoria)
);

CREATE TABLE IF NOT EXISTS produto(
	cod_produto INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	nome VARCHAR(50) NOT NULL UNIQUE,
    quantidade INT UNSIGNED NOT NULL, -- unsigned é sem sinal, economiza um byte
    preco_venda DECIMAL(5,2) NOT NULL,
    quantidade_minima INT UNSIGNED NOT NULL DEFAULT 10,
    
    -- foreign key
    id_categoria INT
);

CREATE TABLE IF NOT EXISTS telefone (
	tel varchar(15)
    
    -- foreign key
    -- id_fornecedor INT PRIMARY KEY NOT NULL AUTO_INCREMENT
);

CREATE TABLE IF NOT EXISTS item_compra (
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    data_compra DATE NOT NULL,
    preco_compra DECIMAL(5,2) NOT NULL,
    quantidade INT NOT NULL,
    inserido TINYINT NOT NULL,
    valor_lucro DECIMAL(4,2) NOT NULL
    
    -- foreign key
    -- cod_produto INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    -- id_usuario INT PRIMARY KEY NOT NULL
);

CREATE TABLE IF NOT EXISTS fornecedor_item (
	-- foreign key
    -- id_compra INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    -- id_fornecedor INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
);

CREATE TABLE IF NOT EXISTS venda (
	cod_venda INT PRIMARY KEY NOT NULL AUTO_INCREMENT
	-- foreign key
    -- id_usuario INT PRIMARY KEY NOT NULL,
);

CREATE TABLE IF NOT EXISTS item_venda (
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    data_venda DATE NOT NULL,
    quantidade INT NOT NULL
    
    -- foreign key
    -- cod_venda INT PRIMARY KEY NOT NULL AUTO_INCREMENT
	-- cod_produto INT PRIMARY KEY NOT NULL AUTO_INCREMENT,    
    -- id_usuario INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
);



