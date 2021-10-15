
-- rf08 done 
SELECT f.nome, p.nome, ic.preco_compra, p.preco_venda
FROM fornecedor as f JOIN fornecedor_item as fi
ON f.id = fi.id_fornecedor
JOIN item_compra as ic
ON ic.id = fi.id_compra
JOIN produto as p 
ON p.cod_produto = ic.cod_produto;

-- rf10 done
SELECT ic.data_compra, ic.preco_compra, ic.quantidade, ic.inserido, p.nome
FROM item_compra as ic JOIN produto as p
ON ic.cod_produto = p.cod_produto;

-- rf11 done
SELECT produto.nome, produto.preco_venda, produto.quantidade
FROM produto
WHERE produto.quantidade > '0';

-- rf13 done
SELECT nome, quantidade from produto WHERE quantidade <= '10';

-- rf16 é para alterar dados

-- rf17 done
SELECT produto.nome, produto.preco_venda, produto.quantidade, categoria.descricao 
FROM produto JOIN categoria
ON categoria.id = produto.id_categoria;

-- rf18 done
SELECT produto.nome, categoria.descricao 
FROM produto JOIN categoria 
ON produto.id_categoria = categoria.id
WHERE categoria.id = '1';

-- rf19
SELECT nome FROM produto WHERE nome LIKE 'agua%';

-- rf20
SELECT preco_venda, nome FROM produto WHERE preco_venda <= '5.0';

-- rf22
SELECT usuario.nome, item_venda.data_venda, produto.nome, item_venda.quantidade, produto.preco_venda
FROM venda JOIN usuario
ON venda.id_usuario = usuario.id
JOIN item_venda 
ON item_venda.cod_venda = venda.cod_venda
JOIN produto 
ON produto.cod_produto = item_venda.cod_produto;

-- rf23
SELECT descricao FROM categoria;

-- exibir dados dos fornecedores
SELECT f.nome, t.telefone 
FROM fornecedor as f JOIN telefone as t
ON t.id_fornecedor = f.id;

-- exibir qual venda foi feita por qual usuário
SELECT usuario.nome, venda.cod_venda 
FROM usuario JOIN venda
ON venda.id_usuario = usuario.id; 

select "Foda-se" as "Bom dia";

