
-- ------------------------------add new supplier--------------------------------------
DELIMITER $$
CREATE PROCEDURE add_new_supplier(nome varchar(20), rua varchar(50), cep varchar(9), numero varchar(10), bairro varchar (20), id_usuario int)
BEGIN
	INSERT INTO fornecedor 
    VALUES (DEFAULT, nome, rua, cep, numero, bairro, id_usuario);
END$$
DELIMITER ;


-- ------------------------------Search for a supplier--------------------------------------
DELIMITER $$
CREATE PROCEDURE search_supplier(id INT)
BEGIN
	SELECT id, nome, rua, cep, numero, bairro, t.telefone
    FROM fornecedor JOIN telefone AS t
    ON fornecedor.id = t.id_fornecedor
    WHERE fornecedor.id = id;
END$$
DELIMITER ;


-- ------------------------------Search for all the suppliers--------------------------------------
DELIMITER $$
CREATE PROCEDURE search_supplier(id INT)
BEGIN
	SELECT *
	FROM fornecedor JOIN telefone AS t
	ON fornecedor.id = t.id_fornecedor;
END$$
DELIMITER ;


-- ------------------------------Update a suppliers--------------------------------------
DELIMITER $$
CREATE PROCEDURE update_supplier(id INT, new_name VARCHAR(20))
BEGIN
	UPDATE fornecedor
    SET nome = new_name
    WHERE fornecedor.id = id;
END$$
DELIMITER ;


-- ------------------------------Delete a supplier--------------------------------------
DELIMITER $$
CREATE PROCEDURE delete_supplier(id INT)
BEGIN
	DELETE FROM fornecedor 
    WHERE fornecedor.id = id;
END$$
DELIMITER ;


