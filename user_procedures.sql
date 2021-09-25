-- ------------------------------Create a new user--------------------------------------
DELIMITER $$
CREATE PROCEDURE create_user(
	user_name VARCHAR(100),
    user_email VARCHAR(100),
    user_password VARCHAR(100)
)
BEGIN

	DECLARE user_id INT;
    
	INSERT INTO usuario 
    VALUES (DEFAULT, user_name, user_email, user_password);
    
    SELECT LAST_INSERT_ID() INTO user_id;
    
    SELECT id, nome, email FROM usuario
    WHERE id = user_id;
END$$
DELIMITER ;

DROP PROCEDURE create_user;
CALL create_user('tes', 'tses@email', '123456897321asd');
select * from usuario;
describe usuario;


-- ------------------------------get user data--------------------------------DONE------
DELIMITER $$
CREATE PROCEDURE get_user(user_email VARCHAR(100))
BEGIN
	SELECT id, nome, email FROM usuario
    WHERE email = user_email;
END$$
DELIMITER ;

drop procedure get_user;
CALL get_user('lucaslameira@gmail.com');
CALL get_user('lucasameira@gmail.com');
describe usuario;

ALTER TABLE usuario
modify column senha VARCHAR(100) NOT NULL;

select * from usuario;

