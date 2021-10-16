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


-- ---------------------------- Register a sale --------------------------------DONE------
DELIMITER $$
CREATE PROCEDURE register_sale(user_id INT)
BEGIN
    DECLARE sale_code INT;
    
    START TRANSACTION;
		INSERT INTO venda (cod_venda, id_usuario) VALUES (DEFAULT, user_id);
        SET sale_code = LAST_INSERT_ID();
	COMMIT;
    
    SELECT sale_code;
END$$
DELIMITER ;

-- ---------------------------- Make a sale --------------------------------DONE------
DELIMITER $$
CREATE PROCEDURE make_sale(
    qty INT,
    cod_product INT,
	cod_sale INT
)
BEGIN
	
    DECLARE product_quantity INT;
    DECLARE _date DATE;
    
	SET _date = CURDATE();
    
    START TRANSACTION;
		-- get quantity of products as 'product_quantity'
		SELECT quantidade INTO product_quantity FROM produto
		WHERE cod_produto = cod_product;
	
		-- ensure there is enough products in stock 
		IF (product_quantity - qty) >= 0 THEN
			INSERT INTO item_venda (data_venda, quantidade, cod_venda, cod_produto) 
			VALUES (_date, qty, cod_sale, cod_product);
            
            SELECT 1;
		ELSE
			SELECT "Quantidade insuficiente no estoque";
		END IF;
    COMMIT;
END$$
DELIMITER ;


drop procedure make_sale;
select * from produto;
select * from item_venda order by cod_venda;
select * from venda;

select * from usuario;
select * from produto;


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



DELIMITER $$
CREATE PROCEDURE teste_proc(xd varchar(50))
BEGIN
	declare cod_teste int;
    start transaction ;
	
    insert into teste (nome) values (xd);
    
    commit;
    set cod_teste = last_insert_id();
    
    select cod_teste;
END$$
DELIMITER ;

select * from teste;
CALL teste_proc("jujujujuju");
drop procedure teste_proc;
describe teste;
describe venda;