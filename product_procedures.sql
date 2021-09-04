
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
DROP PROCEDURE verpreco;


-- ------------------------------RF023 Register default categories--------------------------------------
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


-- ------------------------------Get default categories--------------------------------------
DELIMITER $$
CREATE PROCEDURE get_categories()
BEGIN
	SELECT descricao FROM categoria;
END$$
DELIMITER ;


-- ------------------------------Add new product--------------------------------------
DELIMITER $$
CREATE PROCEDURE add_new_product(
	p_name VARCHAR(50),
	p_qtd INT,
    p_preco_venda DECIMAL(5,2),
	p_qtd_min INT,
    p_id_categoria INT
)
BEGIN
	IF p_qtd_min = 0 OR p_qtd_min = NULL THEN
		INSERT INTO produto (cod_produto, nome, quantidade, preco_venda, quantidade_minima, id_categoria) 
		VALUES (DEFAULT, p_name, p_qtd, p_preco_venda, DEFAULT, 1);
	ELSE    
		INSERT INTO produto (cod_produto, nome, quantidade, preco_venda, quantidade_minima, id_categoria) 
		VALUES (DEFAULT, p_name, p_qtd, p_preco_venda, p_qtd_min, p_id_categoria);
	END IF;
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


-- -------------------------RF017 Search for all the products--------------------------------------
DELIMITER $$
CREATE PROCEDURE search_all_products()
BEGIN
	SELECT nome, quantidade, preco_venda, quantidade_minima, categoria.descricao 
    FROM produto JOIN categoria
    ON produto.id_categoria = categoria.id;
END$$
DELIMITER ;
CALL search_all_products();


-- ------------------------------RF018 Search for a product by category --------------------------------------
DELIMITER $$
CREATE PROCEDURE products_by_category(id INT)
BEGIN
	SELECT produto.nome, categoria.descricao 
	FROM produto JOIN categoria 
	ON produto.id_categoria = categoria.id
	WHERE categoria.id = id;
END$$
DELIMITER ;
CALL products_by_category(1); -- same as CALL products_by_category('1');


-- ------------------------------RF019 Search product by name--------------------------------------
DELIMITER $$
CREATE PROCEDURE search_product_by_name(_nome VARCHAR(50))
BEGIN
	SELECT nome, quantidade, preco_venda quantidade_minima, categoria.descricao 
    FROM produto JOIN categoria
    ON produto.id_categoria = categoria.id
    WHERE produto.nome LIKE CONCAT('%',_nome,'%');
END$$
DELIMITER ;
CALL search_product_by_name('un');


-- ------------------------------RF020 Search product by price--------------------------------------
DELIMITER $$
CREATE PROCEDURE search_product_by_price(price DECIMAL(5, 2))
BEGIN
	SELECT nome, quantidade, preco_venda quantidade_minima, categoria.descricao 
    FROM produto JOIN categoria
    ON produto.id_categoria = categoria.id
    WHERE produto.preco_venda < price;
END$$
DELIMITER ;
CALL search_product_by_price(4.2);


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
	-- pegar a quantidade do produto e verificar se é igual a zero
    -- se não for, verificar usuário e senha para excluir o produto
    
	DELETE FROM produto 
    WHERE cod_produto = codigo; 
END$$
DELIMITER ;


-- RF008------------------------------show product supplier--------------------------------------
DELIMITER $$
CREATE PROCEDURE show_product_supplier()
BEGIN
	SELECT f.nome, p.nome, ic.preco_compra, p.preco_venda
	FROM fornecedor as f JOIN fornecedor_item as fi
	ON f.id = fi.id_fornecedor
	JOIN item_compra as ic
	ON ic.id = fi.id_compra
	JOIN produto as p 
	ON p.cod_produto = ic.cod_produto;
END$$
DELIMITER ;
CALL show_product_supplier();


-- ---------------------- RF011 show products available for sale--------------------------------------
DELIMITER $$
CREATE PROCEDURE products_for_sale()
BEGIN
	SELECT produto.nome, produto.preco_venda, produto.quantidade
	FROM produto
	WHERE produto.quantidade > '0';
END$$
DELIMITER ;
CALL products_for_sale();
