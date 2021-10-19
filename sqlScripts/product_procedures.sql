-- ------------------------------ RF023 Register default categories ---------------------------DONE-------
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
	SELECT * FROM categoria ORDER BY id;
END$$
DELIMITER ;



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
    
	-- Set low-stock accordingly
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
	
    START TRANSACTION;
    
		INSERT INTO produto (cod_produto, nome, quantidade, preco_venda, quantidade_minima, id_categoria, isLowStock) 
		VALUES (DEFAULT, p_name, p_qty, p_sale_price, DEFAULT, p_id_category, isLowStock);
	ELSE
		INSERT INTO produto (cod_produto, nome, quantidade, preco_venda, quantidade_minima, id_categoria, isLowStock) 
		VALUES (DEFAULT, p_name, p_qty, p_sale_price, p_min_qty, p_id_category, isLowStock);
	END IF;
    
    COMMIT;
    
    -- return cod_produto by it's unique name
    SELECT * FROM produto WHERE cod_produto = last_insert_id();
END$$
DELIMITER ;

CALL add_new_product('Heine quem', 36, 7.90, 15, 1);
CALL add_new_product('delete this please 4', 14, 2.90, 10, 1);



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



-- RF017-------------------------RF017 Search for all the products--------------------------------DONE------
DELIMITER $$
CREATE PROCEDURE get_products()
BEGIN
	SELECT 
		cod_produto,
		nome, 
		quantidade, 
        preco_venda, 
        quantidade_minima, 
        isLowStock,
        id_categoria,
        categoria.descricao as categoria
    FROM produto JOIN categoria
    ON produto.id_categoria = categoria.id ORDER BY nome;
END$$
DELIMITER ;



-- RF018------------------------------ Search for a product by category --------------------------DONE--------
DELIMITER $$
CREATE PROCEDURE products_by_category(id INT)
BEGIN
	SELECT 
		cod_produto,
		nome, 
		quantidade, 
        preco_venda, 
        quantidade_minima, 
        isLowStock,
        id_categoria,
        categoria.descricao as categoria
	FROM produto JOIN categoria 
	ON produto.id_categoria = categoria.id
	WHERE categoria.id = id ORDER BY produto.nome;
END$$
DELIMITER ;



-- RF019------------------------------ Search product by name-------------------------------DONE-------
DELIMITER $$
CREATE PROCEDURE search_product_by_name(_nome VARCHAR(50))
BEGIN
	SELECT nome, quantidade, preco_venda quantidade_minima, categoria.descricao 
    FROM produto JOIN categoria
    ON produto.id_categoria = categoria.id
    WHERE produto.nome LIKE CONCAT('%',_nome,'%');
END$$
DELIMITER ;



-- RF020------------------------------ Search product by price-------------------------------DONE-------
DELIMITER $$
CREATE PROCEDURE search_product_by_price(price DECIMAL(5, 2))
BEGIN
	SELECT nome, quantidade, preco_venda quantidade_minima, categoria.descricao 
    FROM produto JOIN categoria
    ON produto.id_categoria = categoria.id
    WHERE produto.preco_venda < price;
END$$
DELIMITER ;



-- RF016------------------------------Update a product--------------------------------DONE------
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
	
	START TRANSACTION;
    
	UPDATE produto 
	SET 
		nome = p_name, 
        quantidade = p_qty,
        preco_venda = p_price,
        quantidade_minima = p_min_qty,
        id_categoria = p_id_category,
        isLowStock = isLowStock
	WHERE cod_produto = p_cod;
    
    COMMIT;
    
    SELECT * FROM produto WHERE cod_produto = p_cod;
END$$
DELIMITER ;



-- RF015-----------------------Delete a product passinng email and password-----------------------DONE--------
DELIMITER $$
CREATE PROCEDURE delete_product(
	product_id INT,
    user_email VARCHAR(50),
    user_password VARCHAR(100)
)
BEGIN
	DECLARE qty INTEGER;
    DECLARE u_email VARCHAR(50);
    DECLARE u_pass VARCHAR(100);    
    
    SELECT quantidade INTO qty FROM produto
    WHERE cod_produto = product_id;
	
    SELECT email, senha INTO u_email, u_pass FROM usuario
    WHERE email = user_email AND senha = user_password;
    
    IF qty = 0 THEN
		DELETE FROM produto 
		WHERE cod_produto = product_id;
	ELSEIF qty > 0 AND iSNULL(u_email) = 0 AND ISNULL(u_pass) = 0 THEN
		DELETE FROM produto 
		WHERE cod_produto = product_id;
	ELSE
		SELECT "Ainda existem produtos no estoque | email e senha incorretos";
	END IF;
END$$
DELIMITER ;


-- RF008------------------------------show product supplier--------------------------------DONE------
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



-- RF011---------------------- show products available for sale ---------------------------DONE---------
DELIMITER $$
CREATE PROCEDURE products_for_sale()
BEGIN
	DECLARE qtd_sale integer;
    SET qtd_sale = 0;
    
	SELECT cod_produto, nome, quantidade as estoque, preco_venda, id_categoria, isLowStock, qtd_sale
	FROM produto JOIN categoria 
	ON produto.id_categoria = categoria.id
	WHERE quantidade > 0 ORDER BY nome;
END$$
DELIMITER ;




-- RF011---------------------- delte product ---------------------------DONE---------
DELIMITER $$
CREATE PROCEDURE delete_product(product_id INT)
BEGIN
	START TRANSACTION;
	
    DELETE FROM produto WHERE cod_produto = product_id;
	
    COMMIT;
END$$
DELIMITER ;