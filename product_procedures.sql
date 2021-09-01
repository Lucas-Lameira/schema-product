
/* Sobre procedures (armazena no servidor de banco de dados??)
sub-rotina disponivel para aplicações que acessam sistemas de banco de dados relacionais
podem ser usadas: validação de dados, controle de acesso, execução de declarações, SQL complexas */

-- ------------------------------criar procedure exemplo ------------------------------
DELIMITER $$
CREATE PROCEDURE verpreco(produtoID SMALLINT)
BEGIN
	SELECT concat('O preço do produto ', nome, ' é: ', preco_venda) AS Preco
	FROM produto
	WHERE cod_produto = produtoID;
    SELECT 'Funcionou';
END$$
DELIMITER ;
 
-- invocar procedure
CALL verpreco(1);


-- ------------------------------Register default categories--------------------------------------
DELIMITER $$
CREATE PROCEDURE register_categories()
BEGIN
	INSERT INTO categoria VALUES
		(default, 'bebida'),
		(default, 'comida'),
		(default, 'utensilios'),
		(default, 'higiene');
END$$
DELIMITER ;


-- ------------------------------add new product--------------------------------------
DELIMITER $$
CREATE PROCEDURE add_new_product(args int)
BEGIN
	INSERT INTO produto (cod_produto, nome, quantidade, preco_venda, quantidade_minima, id_categoria) 
	VALUES (DEFAULT, "agua mineral marcax 20L", 20, 7.00, DEFAULT, 1);
END$$
DELIMITER ;


-- ------------------------------Search for a product--------------------------------------
DELIMITER $$
CREATE PROCEDURE search_product(codigo int)
BEGIN
	SELECT nome, quantidade, preco_venda quantidade_minima, categoria.descricao 
    FROM produto JOIN categoria
    ON produto.id_categoria = categoria.id
    WHERE cod_produto = codigo;
END$$
DELIMITER ;


-- ------------------------------Search for all the products--------------------------------------
DELIMITER $$
CREATE PROCEDURE search_all_products()
BEGIN
	SELECT nome, quantidade, preco_venda quantidade_minima, categoria.descricao 
    FROM produto JOIN categoria
    ON produto.id_categoria = categoria.id;
END$$
DELIMITER ;


-- ------------------------------Update a product--------------------------------------
DELIMITER $$
CREATE PROCEDURE update_product(codigo int, preco float)
BEGIN
	UPDATE produto 
    SET preco_venda = preco
    WHERE cod_produto = codigo;
END$$
DELIMITER ;


-- ------------------------------Delete a product--------------------------------------
DELIMITER $$
CREATE PROCEDURE delete_product(codigo int)
BEGIN
	DELETE FROM produto 
    WHERE cod_produto = codigo; 
END$$
DELIMITER ;


