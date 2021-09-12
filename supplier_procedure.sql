-- ------------------------------ add new supplier ------------------------------DONE--------
DELIMITER $$
CREATE PROCEDURE add_new_supplier(
	nome VARCHAR(50), 
    rua VARCHAR(50), 
    cep VARCHAR(9), 
    numero VARCHAR(10), 
    bairro VARCHAR (20), 
    id_usuario INT
)
BEGIN
	INSERT INTO fornecedor 
    VALUES (DEFAULT, nome, rua, cep, numero, bairro, id_usuario);
    
    -- return the id
    SELECT id FROM fornecedor 
    WHERE fornecedor.nome = nome;
END$$
DELIMITER ;

CALL add_new_supplier('má teus', 'augusto montenegro', '00000-016', '3100', 'aguas molhadas', 2);
DROP PROCEDURE add_new_supplier;
describe telefone;
SELECT * FROM fornecedor;


-- ------------------------------add new supplier's phone-----------------------------DONE--------
DELIMITER $$
CREATE PROCEDURE add_new_supplier_phone(cellphone VARCHAR(15), id_supplier INT)
BEGIN

	DECLARE verifyID INT;
	
    SELECT id INTO verifyID FROM  fornecedor 
    WHERE id = id_supplier;
    
    IF isNULL(verifyID) = 1 THEN
		SELECT "O ID do Fornecedor Não existe";
	ELSE
		INSERT INTO telefone
        VALUES (cellphone, id_supplier);
    END IF;
END$$
DELIMITER ;
CALL add_new_supplier_phone('(91) 9202-1015', 11);
SELECT * FROM telefone;


-- ------------------------------Search supplier and phone-------------------------------DONE-------
DELIMITER $$
CREATE PROCEDURE search_supplier(id INT)
BEGIN
	SELECT id, nome, rua, cep, numero, bairro, t.telefone
    FROM fornecedor JOIN telefone AS t
    ON fornecedor.id = t.id_fornecedor
    WHERE fornecedor.id = id;
END$$
DELIMITER ;
CALL search_supplier(11);
select * from fornecedor;


-- ------------------------------Search suppliers and phones-----------------------------DONE---------
DELIMITER $$
CREATE PROCEDURE search_suppliers()
BEGIN
	SELECT *
	FROM fornecedor JOIN telefone
	ON fornecedor.id = telefone.id_fornecedor;
END$$
DELIMITER ;
CALL search_suppliers();


-- ------------------------------Update a suppliers------------------------------DONE-------
DELIMITER $$
CREATE PROCEDURE update_supplier(
	_id INT,
	new_nome VARCHAR(50), 
    new_rua VARCHAR(50), 
    new_cep VARCHAR(9), 
    new_numero VARCHAR(10), 
    new_bairro VARCHAR (20),
    new_id_usuario INT
)
BEGIN
	UPDATE fornecedor
    SET 
		nome = new_nome, 
		rua = new_rua, 
        cep = new_cep, 
        numero = new_numero, 
        bairro = new_bairro,
        id_usuario = new_id_usuario
    WHERE fornecedor.id = _id;
END$$
DELIMITER ;
CALL update_supplier(7, 'Atacadinho', 'Passagem Alves', '06123-000', '1645', 'Pratinha', 2);
SELECT * FROM fornecedor;


-- ------------------------------Update a supplier's phone---------------------------DONE-----------
DELIMITER $$
CREATE PROCEDURE update_supplier_phone(cellphone VARCHAR(15), id_supplier INT)
BEGIN
	UPDATE telefone
    SET 
		telefone = cellphone
    WHERE id_fornecedor = id_supplier;
END$$
DELIMITER ;
DROP PROCEDURE update_supplier_phone;
CALL update_supplier_phone('(91) 92021-2015', 11);
SELECT * FROM telefone;


-- ------------------------------Delete a supplier--------------------------------DONE------
DELIMITER $$
CREATE PROCEDURE delete_supplier(id INT)
BEGIN
	DELETE FROM fornecedor 
    WHERE fornecedor.id = id;
END$$
DELIMITER ;

CALL delete_supplier(7);
SELECT * FROM fornecedor;


-- ------------------------------Delete a supplier's PHONE--------------------------------DONE------
DELIMITER $$
CREATE PROCEDURE delete_supplier_phone(id INT, phone VARCHAR(15))
BEGIN
	DELETE FROM telefone 
    WHERE id_fornecedor = id AND telefone = phone;
END$$
DELIMITER ;
DROP PROCEDURE delete_supplier_phone;
CALL delete_supplier_phone(2, '(91) 97979-8787');
SELECT * FROM telefone;

