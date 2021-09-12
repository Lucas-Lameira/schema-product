-- disparado quando um com comando dml ocorrer em uma tabela  (INSERT, UPDATE, DELETE)

-- verificar se dado integro
-- validar dados (tipos de dados, faiza de valor)
-- rastreamento de registros de logs na tabela
-- é armazenado em um arquivo separado
-- arquivar registros excluidos
-- é disparado quando ocorre um evento dml

/*
CREATE TRIGGER  nome timing operação
ON tabela
FOR EACH ROW
declarações;

nome - qualquer nome 
timing - BEFORE (antes do comando dml ser executado) e AFTER (dps do comando dml ser execuado)
operação insert, update, delete


CREATE TRIGGER product_profit BEFORE INSERT
ON item_compra 
FOR EACH ROW
*/



-- trigger para monitorar as quantidades mínimas especificadas
DELIMITER $$
CREATE TRIGGER check_min_qtd_insert 
AFTER INSERT ON produto
FOR EACH ROW 
BEGIN 
	DECLARE quantity INTEGER;
    DECLARE min_quantity INTEGER;
    
    SELECT quantidade, quantidade_minima INTO quantity, min_quantity FROM produto
    WHERE produto.cod_produto = cod_produto;
    
	IF quantity < quantidade_minima THEN
		SELECT "alert: quantidade minima atingida, considere uma compra para estoque";
	END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER check_min_qtd_update 
AFTER UPDATE ON produto FOR EACH ROW 
BEGIN 
	DECLARE quantity INTEGER;
    DECLARE min_quantity INTEGER;
    
    SELECT quantidade, quantidade_minima INTO quantity, min_quantity FROM produto
    WHERE produto.cod_produto = cod_produto;
    
	IF quantity < quantidade_minima THEN
		SELECT "alert: quantidade minima atingida, considere uma compra para estoque";
	END IF;
END$$
DELIMITER ;

-- triger para inserir um produto comprado na tabela produtos
-- trigger para alterar o 'preco-venda' da tabela produtos
