-- Sobre procedures : validação de dados, controle de acesso, execução de declarações, SQL complexas
-- ------------------------------RF023 Register default categories---------------------------DONE-------
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


-- ------------------------------Get default categories-------------------------------DONE-------
DELIMITER $$
CREATE PROCEDURE get_categories()
BEGIN
	SELECT * FROM categoria;
END$$
DELIMITER ;

CALL get_categories();


-- ------------------------------Add new product-------------------------------DONE-------
DELIMITER $$
CREATE PROCEDURE add_new_product(
	p_name VARCHAR(50),
	p_qty INT,
    p_sale_price DECIMAL(5,2),
	p_min_qty INT,
    p_id_category INT
)
BEGIN
	DECLARE isLowStock TINYINT;
    
	IF p_qty <= p_min_qty THEN
		SET isLowStock = 1;
	ELSE 
		SET isLowStock = 0;
    END IF;
    
	IF p_min_qty = 0 OR ISNULL(p_min_qty) = 1 THEN
		IF p_qty <= 10 THEN 
			SET isLowStock = 1;
		ELSE 
			SET isLowStock = 0;
		END IF;
        
		INSERT INTO produto (cod_produto, nome, quantidade, preco_venda, quantidade_minima, id_categoria, isLowStock) 
		VALUES (DEFAULT, p_name, p_qty, p_sale_price, DEFAULT, p_id_category, isLowStock);
	ELSE
		INSERT INTO produto (cod_produto, nome, quantidade, preco_venda, quantidade_minima, id_categoria, isLowStock) 
		VALUES (DEFAULT, p_name, p_qty, p_sale_price, p_min_qty, p_id_category, isLowStock);
	END IF;
    
    -- return cod_produto by it's unique name
    SELECT cod_produto FROM produto WHERE nome = p_name;
END$$
DELIMITER ;

CALL add_new_product('Heine quem', 36, 7.90, 15, 1);
CALL add_new_product('suco de biribá', 5, 7.90, 0, 1);


-- ------------------------------Search for a product------------------------------DONE--------
DELIMITER $$
CREATE PROCEDURE search_product(codigo int)
BEGIN
	SELECT nome, quantidade, preco_venda quantidade_minima, categoria.descricao as catagoria 
    FROM produto JOIN categoria
    ON produto.id_categoria = categoria.id
    WHERE cod_produto = codigo;
END$$
DELIMITER ;
drop procedure search_product;
call search_product(5);


-- -------------------------RF017 Search for all the products--------------------------------DONE------
DELIMITER $$
CREATE PROCEDURE search_all_products()
BEGIN
	SELECT nome, quantidade, preco_venda, quantidade_minima, categoria.descricao as categoria
    FROM produto JOIN categoria
    ON produto.id_categoria = categoria.id;
END$$
DELIMITER ;
DROP PROCEDURE search_all_products;
CALL search_all_products();


-- ------------------------------RF018 Search for a product by category --------------------------DONE--------
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


-- ------------------------------RF019 Search product by name-------------------------------DONE-------
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


-- ------------------------------RF020 Search product by price-------------------------------DONE-------
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


-- ------------------------------Update a product--------------------------------DONE------
DELIMITER $$
CREATE PROCEDURE update_product(
	p_cod INT, 
    p_name VARCHAR(50),
    p_qty INT,
    p_price DECIMAL(5,2),
    p_min_qty INT,
    p_id_category INT
)
BEGIN
	DECLARE isLowStock TINYINT;
    
	IF p_qty <= p_min_qty THEN
		SET isLowStock = 1;
	ELSE
		SET isLowStock = 0;
    END IF;
		
	UPDATE produto 
	SET 
		nome = p_name, 
        quantidade = p_qty,
        preco_venda = p_price,
        quantidade_minima = p_min_qty,
        id_categoria = p_id_category,
        isLowStock = isLowStock
	WHERE cod_produto = p_cod;
END$$
DELIMITER ;
drop procedure update_product;
CALL update_product(3, 'cerveja skola beet', 31, 3.90, 30, 1);
select * from produto;


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