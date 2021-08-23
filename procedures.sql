
/* Sobre procedures
sub-rotina disponivel para aplicações que acessam sistemas de banco de dados relacionais
podem ser usadas: validação de dados, controle de acesso, execução de declarações, SQL complexas */

-- criar procedure
DELIMITER $$
CREATE PROCEDURE verpreco(produtoID SMALLINT)
BEGIN
	SELECT concat('O preço do produto ', nome, ' é: ', preco_venda) AS Preco
	FROM produto
	WHERE cod_produto = produtoID;
    SELECT 'Funcionou';
END$$
DELIMITER ;
 
-- invocar procedure
CALL verpreco(1);

-- ----------------------------------------------------------------------------------

