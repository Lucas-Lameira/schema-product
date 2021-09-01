-- invocado com comando dml e é associado a uma tabela 

-- verificar se dado integro
-- validar dados (tipos de dados, faiza de valor)
-- rastreamento de registros de logs
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
