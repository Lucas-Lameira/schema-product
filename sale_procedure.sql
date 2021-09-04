-- ---------------------------- RF022 Show sales history --------------------------------------
DELIMITER $$
CREATE PROCEDURE sales_history()
BEGIN
	SELECT usuario.nome, item_venda.data_venda, produto.nome, item_venda.quantidade, produto.preco_venda
	FROM venda JOIN usuario
	ON venda.id_usuario = usuario.id
	JOIN item_venda 
	ON item_venda.cod_venda = venda.cod_venda
	JOIN produto 
	ON produto.cod_produto = item_venda.cod_produto;
END$$
DELIMITER ;

CALL sales_history();