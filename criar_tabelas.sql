-- formato de : yyyy-mm-dd
create database gerenciamentoEstoqueVenda;
drop database gerenciamentoEstoqueVenda;
use gerenciamentoEstoqueVenda;

CREATE TABLE IF NOT EXISTS usuario (
	id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE, 
    senha VARCHAR(20) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS fornecedor (
	id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(20) NOT NULL,
    rua VARCHAR(50) NOT NULL,
    cep VARCHAR(9) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    bairro VARCHAR(20) NOT NULL,
    id_usuario INT,
    PRIMARY KEY (id),
    FOREIGN KEY (id_usuario) REFERENCES usuario (id) ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS categoria(
	id INT AUTO_INCREMENT NOT NULL,
	descricao VARCHAR(15) NOT NULL UNIQUE,
    PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS produto(
	cod_produto INT NOT NULL AUTO_INCREMENT,
	nome VARCHAR(50) NOT NULL UNIQUE,
    quantidade INT UNSIGNED NOT NULL, -- unsigned é sem sinal, economiza um byte
    preco_venda DECIMAL(5,2) NOT NULL,
    quantidade_minima INT UNSIGNED NOT NULL DEFAULT 10,
    id_categoria INT,
    PRIMARY KEY(cod_produto),
    FOREIGN KEY (id_categoria) REFERENCES categoria (id) ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS telefone (
	telefone varchar(15),
    id_fornecedor INT NOT NULL,
    PRIMARY KEY (telefone, id_fornecedor),
    FOREIGN KEY (id_fornecedor) REFERENCES fornecedor (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS item_compra (
	id INT NOT NULL AUTO_INCREMENT,
    data_compra DATE NOT NULL,
    preco_compra DECIMAL(5,2) NOT NULL,
    quantidade INT UNSIGNED NOT NULL,
    inserido TINYINT NOT NULL,
    lucro DECIMAL(4,2) UNSIGNED NOT NULL,
    id_usuario INT NOT NULL,
    cod_produto INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_usuario) REFERENCES usuario (id) ON DELETE RESTRICT,
    FOREIGN KEY (cod_produto) REFERENCES produto (cod_produto) ON DELETE RESTRICT
);
describe item_compra;

CREATE TABLE IF NOT EXISTS fornecedor_item (
	id_compra INT NOT NULL,
	id_fornecedor INT NOT NULL,
    PRIMARY KEY (id_compra, id_fornecedor),
    FOREIGN KEY (id_compra) REFERENCES item_compra (id) ON DELETE CASCADE,
    FOREIGN KEY (id_fornecedor) REFERENCES fornecedor (id) ON DELETE CASCADE 
);

CREATE TABLE IF NOT EXISTS venda (
	cod_venda INT NOT NULL AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    PRIMARY KEY (cod_venda),
    FOREIGN KEY (id_usuario) REFERENCES usuario (id) ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS item_venda (
	id INT NOT NULL AUTO_INCREMENT,
    data_venda DATE NOT NULL,
    quantidade INT NOT NULL,
    cod_venda INT NOT NULL,
    cod_produto INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (cod_venda) REFERENCES venda (cod_venda) ON DELETE CASCADE,
    FOREIGN KEY (cod_produto) REFERENCES produto (cod_produto) ON DELETE CASCADE
);



