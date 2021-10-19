SET GLOBAL log_bin_trust_function_creators = 1;
-- ------------------------------ Raise price Function -----------------------------DONE---------
DELIMITER $$
CREATE FUNCTION raise_price(price DECIMAL(5,2), profit DECIMAL(4,2)) 
RETURNS DECIMAL(5,2)
BEGIN 
	RETURN price * (profit/100) + price;
END$$
DELIMITER ;


-- ----------drop this -------------RF010 New purchase -------------------------------DONE----------
DELIMITER $$
CREATE PROCEDURE new_purchase(
    price DECIMAL(5,2), 
    product_qty INT,
    isInsertedInProduct TINYINT, 
    profit DECIMAL (4,2),
    user_id INT, 
    cod_product INT,
    id_supplier INT
)
BEGIN
	
    -- variables
	DECLARE _date DATE;
    
    DECLARE new_price DECIMAL(5, 2);
    DECLARE stock INTEGER;
    DECLARE new_stock INTEGER;
    DECLARE min_qty INTEGER;
    DECLARE isQtyBelow TINYINT;
    
    DECLARE supplierExists INT;
    DECLARE purchase_id INT;
    
    -- assign variables
    SELECT quantidade, quantidade_minima, isLowStock
    INTO stock, min_qty, isQtyBelow FROM produto
    WHERE cod_produto = cod_product;
	
    SET _date = CURDATE();
    
	START TRANSACTION;
	
    
	INSERT INTO item_compra
    VALUES (
		DEFAULT,
        _date, 
        price, 
        product_qty, 
        isInsertedInProduct, 
        profit, 
        user_id, 
        cod_product
	);
	-- get the auto increment id
    SELECT LAST_INSERT_ID() INTO purchase_id;
    
    -- check if supllier exists
    SELECT id INTO supplierExists FROM fornecedor 
    WHERE id = id_supplier;

    IF ISNULL(supplierExists) = 0 THEN
		INSERT INTO fornecedor_item
		VALUES (purchase_id, id_supplier);
	END IF;
    
    -- check if the user wants to insert in the table product
    IF isInsertedInProduct = 1 THEN
		-- stock variable to update product stock
		SET new_stock = stock + product_qty;
    
		-- new price for product table
		SET new_price = raise_price(price, profit);
    
		UPDATE produto
        SET preco_venda = new_price, quantidade = new_stock
        WHERE cod_produto = cod_product;
    END IF;
    
    IF new_stock > min_qty AND isQtyBelow = 1 THEN
		UPDATE produto
        SET isLowStock = 0
        WHERE cod_produto = cod_product;
	END IF;
    
    COMMIT;
END$$
DELIMITER ;

-- _date, price, product_qty, isInsertedInProduct, profit, user_id, cod_product, id_supplier
CALL new_purchase('2021-05-07', 2.85, 2, 1, 15.0, 1, 3, 1);
DROP PROCEDURE new_purchase;
select * from produto;
select * from item_compra;
select * from fornecedor_item;


-- RF009---------------------- update product when 'isInserted' change ---------------------DONE------
DELIMITER $$
CREATE TRIGGER change_product
AFTER UPDATE ON item_compra FOR EACH ROW 
BEGIN
	DECLARE new_price DECIMAL(5,2);
	DECLARE new_stock INTEGER;
	
	-- get 'product' data
	DECLARE stock INTEGER;
	DECLARE min_qty INTEGER;
	DECLARE isQtyBelow TINYINT;
	
    IF NEW.inserido = 1 AND OLD.inserido = 0 THEN
    
		-- assign variables with 'product' data
		SELECT quantidade, quantidade_minima, isLowStock
		INTO stock, min_qty, isQtyBelow FROM produto
		WHERE cod_produto = NEW.cod_produto;
        
        SET new_price = raise_price(NEW.preco_compra, NEW.lucro);
        SET new_stock = stock + NEW.quantidade;
        
        IF new_stock > min_qty AND isQtyBelow = 1 THEN
			SET isQtyBelow = 0;
            UPDATE produto
			SET quantidade = new_stock, preco_venda = new_price, isLowStock = isQtyBelow
			WHERE cod_produto = NEW.cod_produto;
		ELSE
			UPDATE produto
			SET quantidade = new_stock, preco_venda = new_price
			WHERE cod_produto = NEW.cod_produto;
        END IF;
        
    END IF;
END$$
DELIMITER ;



-- ------------------------------ update purchase --------------------------------DONE------
DELIMITER $$
CREATE PROCEDURE update_purchase(
	_id INT,
	_date DATE, 
    price DECIMAL(5,2),
    product_qty INT,
    isInsertedInProduct TINYINT, 
    profit DECIMAL (4,2), 
    user_id INT, 
    cod_product INT
)
BEGIN
	DECLARE isInserted TINYINT;
	
    SELECT inserido INTO isInserted FROM item_compra
    WHERE id = _id;
    
    START TRANSACTION;
    
	IF isInserted = 1 THEN
		SELECT "Não é possível alterar um produto que ja foi inserido no estoque";
	ELSE 
		UPDATE item_compra
		SET data_compra = _date, 
            preco_compra = price,
            quantidade = product_qty,
            inserido = isInsertedInProduct,
            lucro = profit,
            id_usuario = user_id,
            cod_produto = cod_product
		WHERE id = _id;
	END IF;
    COMMIT;
    
    SELECT * FROM item_compra
    WHERE id = _id;
END$$
DELIMITER ;

drop procedure update_purchase;
CALL update_purchase(1, '2021-05-07', 2.89, 12, 1, 75.00, 1, 8);
select * from item_compra;
select * from produto;
describe item_compra;



-- RF010------------------------------ show purchase history ------------------------------DONE--------
DELIMITER $$
CREATE PROCEDURE purchase_history()
BEGIN
	SELECT ic.data_compra, ic.preco_compra, ic.quantidade, ic.inserido, p.nome
	FROM item_compra as ic JOIN produto as p
	ON ic.cod_produto = p.cod_produto;
END$$
DELIMITER ;
CALL purchase_history();


-- ------------------------------ Delete purchase --------------------------------DONE------
DELIMITER $$
CREATE PROCEDURE delete_purchase(_id INT)
BEGIN
	DELETE FROM item_compra WHERE id = _id;
END$$
DELIMITER ;
CALL delete_purchase(1);

select * from item_compra;
