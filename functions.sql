-- SET GLOBAL log_bin_trust_function_creators = 1;

-- funções são usadas para gerar um valor que pode ser usado em uma expressão. É executada como parte de um expressão

-- aumentar preço de compra para preco de venda
DELIMITER $$
CREATE FUNCTION aumentaPreco (compra FLOAT, lucro FLOAT) 
RETURNS INT
BEGIN 
	RETURN compra * (lucro/100) + compra;
END$$
DELIMITER ;
DROP FUNCTION aumentaPreco;

SELECT aumentaPreco(5.5, 15) AS RESULTADO;


-- inserir na tabela produto os itens de compra, com valor atualizado
/*CREATE FUNCTION lucro_sobre_produto(preco_compra FLOAT, lucro float)
RETURNS float


-- price of x unities
CREATE FUNCTION get_price(price FLOAT, units INT)
RETURNS FLOAT
RETURN price * units;

SELECT nome, get_price(preco_venda, 4) AS 'preço de x unidades'
FROM produto
WHERE cod_produto = 1;


describe produto;

SELECT * FROM produto;

-- criando funções:
CREATE FUNCTION soma(x INT, y FLOAT)
RETURNS FLOAT
RETURN x + y;

-- invocando a função:  
SELECT soma(15, 28.5) AS soma;*/
	