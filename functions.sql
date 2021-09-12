-- SET GLOBAL log_bin_trust_function_creators = 1;

-- funções são usadas para gerar um valor que pode ser usado em uma expressão. É executada como parte de um expressão

-- aumentar preço de compra para preco de venda



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


/*
obs: 
1 - onde os dados devem ser validado
2 - como que funciona esse servidor de banco de dados que armazena as procedures
	
*/

-- implementações
-- criar novo produto
-- exibir um produto
-- alterar um produto
-- deletar um produto



	