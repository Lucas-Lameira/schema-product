-- RF022----------------------------  Show sales history --------------------------------DONE------
DELIMITER $$
CREATE PROCEDURE sales_history()
BEGIN
	SELECT 
		item_venda.cod_venda, 
        usuario.id as user_id, 
        usuario.nome as user_email,
        usuario.email,
        item_venda.data_venda, 
        produto.cod_produto,
        produto.nome, 
        item_venda.quantidade, 
        produto.preco_venda
	FROM venda JOIN usuario
	ON venda.id_usuario = usuario.id
	JOIN item_venda 
	ON item_venda.cod_venda = venda.cod_venda
	JOIN produto 
	ON produto.cod_produto = item_venda.cod_produto ORDER BY data_venda;
END$$
DELIMITER ;

drop procedure sales_history;
CALL sales_history();



-- ---------------------------- Make a sale --------------------------------DONE------
DELIMITER $$
CREATE PROCEDURE make_sale(
	user_id INT,
	_date DATE,
    qtd INT,
    cod_sale INT,
    cod_product INT)
BEGIN

    DECLARE product_quantity INT;
	DECLARE sale INT;
    
    -- get result set as sale to check it it's null or not
    SELECT cod_venda INTO sale 
    FROM venda 
    WHERE id_usuario = user_id AND cod_venda = cod_sale;
    
    
    START TRANSACTION;
    -- cadastrar venda a venda se ela não existir, varios itens_venda mas uma venda só! 
    IF ISNULL(sale) = 1 THEN
		INSERT INTO venda (cod_venda, id_usuario) VALUES (cod_sale, user_id);
	END IF;
    
    -- get quantity of products as 'product_quantity'
    SELECT quantidade INTO product_quantity FROM produto
    WHERE cod_produto = cod_product;
	
    -- ensure there is enough products in stock 
    IF (product_quantity - qtd) >= 0 THEN
		INSERT INTO item_venda (data_venda, quantidade, cod_venda, cod_produto) 
		VALUES (_date, qtd, cod_sale, cod_product);
    ELSE
		SELECT "Quantidade insuficiente no estoque";
    END IF;
    COMMIT;
END$$
DELIMITER ;
CALL make_sale(2, '2021-12-09', 2, 6, 8); -- user_id, date, qtd, cod_venda, cod_produto
select * from produto;
select * from item_venda order by cod_venda;
select * from venda;


-- RF013----------------------------Trigger when sale---------------------------------DONE-----
DELIMITER $$
CREATE TRIGGER update_product_when_sale
AFTER INSERT ON item_venda FOR EACH ROW
BEGIN
    DECLARE stock INTEGER;
    DECLARE min_qty INTEGER;
    DECLARE remaining_stock INTEGER;
    
    -- get stock and minimum quantity
    SELECT quantidade, quantidade_minima INTO stock, min_qty FROM produto
    WHERE cod_produto = NEW.cod_produto;
    
    -- get the remaining stock quantity
    SET remaining_stock = stock - NEW.quantidade;
    
    -- update stock quantity
	UPDATE produto 
    SET quantidade = remaining_stock
    WHERE cod_produto = NEW.cod_produto;

	-- update the stock alert if there are few products
	IF remaining_stock <= min_qty THEN
		UPDATE produto SET isLowStock = 1
		WHERE cod_produto = NEW.cod_produto;
    END IF;
END$$
DELIMITER ;


-- ----------------------------delete sale---------------------------------DONE-----
DELIMITER $$
CREATE PROCEDURE delete_sale(sale_code INT)
BEGIN
	DELETE FROM venda 
    WHERE cod_venda = sale_code;
END$$
DELIMITER ;

CALL delete_sale(1);