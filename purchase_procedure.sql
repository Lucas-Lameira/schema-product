-- itens de compra

-- ------------------------------ New purchase --------------------------------------
DELIMITER $$
CREATE PROCEDURE new_purchase(data_compra DATE, preco_compra DECIMAL(5,2), quantidade INT, inserido TINYINT, lucro DECIMAL (4,2), id_usuario INT, cod_produto INT)
BEGIN
	-- verificar se o código do produto existe, se não existir deve cadastrar o produto
    -- CAll add_new_product(args);

	INSERT INTO item_compra 
    VALUES (DEFAULT, data_compra, preco_compra, quantidade, inserido, lucro, id_usuario, cod_produto);
END$$
DELIMITER ;



