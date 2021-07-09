-- date data "1980-06-25"
-- usuario
INSERT INTO usuario (id, nome, email, senha)  VALUES (DEFAULT, "lucas lameira", "lucaslameira@gmail.com", "123456");
INSERT INTO usuario VALUES (DEFAULT, "leandro ribeiro", "leandroribeiro@gmail.com", "7891011");
describe usuario;

-- categoria
INSERT INTO categoria (id, descricao) VALUES (default, 'bebida');
INSERT INTO categoria VALUES
    (default, 'comida'),
    (default, 'utensilios'),
    (default, 'higiene');

-- fornecedor 
INSERT INTO fornecedor (id, nome, rua, cep, numero, bairro, id_usuario) VALUES (DEFAULT, "fonecedouro", "RUA", "CEP", "NUMERO", "BAIRRO", 1);
INSERT INTO fornecedor VALUES	
    (DEFAULT, "atacadinho", "passagem alves", "06123-066", "1645", "pratinha", 1),
    (DEFAULT, "liderezoom", "1° de abril", "05846-047", "1200", "bairro do marco", 1),
    (DEFAULT, "super mercaderoi", "padre julio maria", "04567-987", "985", "cruzeiro", 1),
    (DEFAULT, "emporio coquetel", "quinta rua", "45678-068", "465", "umarizal", 2);

-- telefone
INSERT INTO telefone (telefone, id_fornecedor) VALUES ("(91) 98989-8989", 2);
INSERT INTO telefone VALUES 
	("(91) 97979-8787", 2),
    ("(91) 96868-8686", 1), 
    ("(91) 98585-8585", 3), 
    ("(91) 91212-2121", 4),
    ("(91) 93535-5353", 4),
    ("(91) 91234-5847", 5); 

-- produto 
INSERT INTO produto (cod_produto, nome, quantidade, preco_venda, quantidade_minima, id_categoria) 
VALUES (DEFAULT, "agua mineral marcax 20L", 20, 7.00, DEFAULT, 1);
INSERT INTO produto VALUES
	(DEFAULT, "macarrao legal 250g", 16, 3.50, 5, 2),
    (DEFAULT, "cerveja skola beet", 0, 5.00, 30, 1),
    (DEFAULT, "papel higienio 6 rolos", 15, 4.50, 8, 4),
    (DEFAULT, "arroz tia joelma 1kg", 26, 6.20, 6, 2),
    (DEFAULT, "cortador de unha", 12, 8.88, 2, 3),
    (DEFAULT, "feijão galopero 500g", 17, 4.99, DEFAULT, 2),
    (DEFAULT, "café desunião", 4, 4.83, 6, 1);
INSERT INTO produto (nome, quantidade, preco_venda, quantidade_minima, id_categoria) values ('Miojo tailandes', 0, 2.50, DEFAULT, 2);

-- item compra
INSERT INTO item_compra (id, data_compra, preco_compra, quantidade, inserido, lucro, id_usuario, cod_produto) 
VALUES (DEFAULT, "2021-05-05", 2.89, 12, false, '15', 1, 8);

INSERT INTO item_compra VALUES
	(DEFAULT, "2021-05-06", 2.80, 12, true, '15', 1, 2),
    (DEFAULT, '2021-05-07', 7.40, 2, true, '15', 1, 6),
    (DEFAULT, '2021-05-07', 3.20, 6, false, '15', 1, 4),
    (DEFAULT, '2021-05-07', 4.80, 10, false, '15', 1, 5),
    (DEFAULT, '2021-05-09', 4.10, 28, false, '15', 1, 3),
    (DEFAULT, '2021-05-09', 3.20, 8, true, '15', 1, 7),
    (DEFAULT, '2021-05-15', 5.50, 5, true, '15', 1, 1),
    (DEFAULT, '2021-06-05', 3.20, 6, true, '16', 1, 4),
    (DEFAULT, '2021-06-06', 3.20, 8, true, '16', 1, 1);

-- fornecedor item
INSERT INTO fornecedor_item (id_compra, id_fornecedor) VALUES (1, 2);
INSERT INTO fornecedor_item  VALUES 
	(2, 1),
    (3, 1),
    (4, 3),
    (5, 2),
    (6, 5),
    (7, 4),
    (8, 5),
    (9, 4),
    (10, 3);

-- venda
INSERT INTO venda (cod_venda, id_usuario) VALUES (1, 1);
INSERT INTO venda values 
  (2, 1), (3, 1), (4, 1), (5, 1),
  (6, 2), (7, 2), (8, 2),
  (9, 1), (10, 1),
  (11, 2), (12, 2),
  (13, 1), (14, 1),
  (15, 2), (16, 2), (17, 2), (18, 2),
  (19, 1), (20, 1);
  
-- item venda 
INSERT INTO item_venda (id, data_venda, quantidade, cod_venda, cod_produto) 
VALUES (1, '2021-06-07', 1, 1, 1);
INSERT INTO item_venda VALUES
  (2, '2021-06-07', 2, 2, 5),
  (3, '2021-06-07', 8, 3, 3),
  (4, '2021-06-07', 1, 4, 7),
  (5, '2021-06-07', 3, 5, 2),
  (6, '2021-06-08', 1, 6, 4),
  (7, '2021-06-08', 2, 7, 5),
  (8, '2021-06-08', 3, 8, 5),
  (9, '2021-06-09', 4, 9, 8),
  (10, '2021-06-09', 1, 10, 6);
