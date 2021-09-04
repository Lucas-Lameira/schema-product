-- itens de compra

-- ------------------------------RF010 New purchase --------------------------------------
DELIMITER $$
CREATE PROCEDURE new_purchase(
	data_compra DATE, 
    preco_compra DECIMAL(5,2), 
    quantidade INT, 
    inserido TINYINT, 
    lucro DECIMAL (4,2), 
    id_usuario INT, 
    cod_produto INT
)
BEGIN
	-- verificar se o código do produto existe, se não existir deve cadastrar o produto
    -- CAll add_new_product(args);
    
	INSERT INTO item_compra
    VALUES (DEFAULT, data_compra, preco_compra, quantidade, inserido, lucro, id_usuario, cod_produto);
END$$
DELIMITER ;


-- ------------------------------ show purchase history --------------------------------------
DELIMITER $$
CREATE PROCEDURE purchase_history()
BEGIN
	SELECT ic.data_compra, ic.preco_compra, ic.quantidade, ic.inserido, p.nome
	FROM item_compra as ic JOIN produto as p
	ON ic.cod_produto = p.cod_produto;
END$$
DELIMITER ;
CALL purchase_history();


-- ------------------------------ show purchase history --------------------------------------
DELIMITER $$
CREATE PROCEDURE purchase_history()
BEGIN
	SELECT ic.data_compra, ic.preco_compra, ic.quantidade, ic.inserido, p.nome
	FROM item_compra as ic JOIN produto as p
	ON ic.cod_produto = p.cod_produto;
END$$
DELIMITER ;
CALL purchase_history();


-- ------------------------------ Delete purchase --------------------------------------
DELIMITER $$
CREATE PROCEDURE delete_purchase(_id int)
BEGIN
	DELETE FROM item_compra WHERE id = _id;
END$$
DELIMITER ;
CALL delete_purchase();