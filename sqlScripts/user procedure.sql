SET GLOBAL log_bin_trust_function_creators = 1;

-- ----------------------------Validade user in login --------------------------------DONE
DELIMITER $$
CREATE FUNCTION validate_user(user_email VARCHAR(100), user_password VARCHAR(100))
RETURNS TINYINT
BEGIN 

	DECLARE userExists TINYINT;
    
	SELECT id INTO userExists FROM usuario
    WHERE email = user_email AND user_password = senha;
	
    -- is it null
    IF ISNULL(userExists) = 1 THEN
		SET userExists = 0;
	ELSE
		SET userExists = 1;
	END IF;
    
    RETURN userExists;
END$$
DELIMITER ;


DELIMITER $$
CREATE FUNCTION validate_userId(user_id INT)
RETURNS TINYINT
BEGIN 

	DECLARE userIdExists TINYINT;
    
	SELECT id INTO userIdExists FROM usuario
    WHERE id = user_id;
	
    -- is it null
    IF ISNULL(userIdExists) = 1 THEN
		SET userIdExists = 0; -- invalid
	ELSE
		SET userIdExists = 1; -- valid
	END IF;
    
    RETURN userIdExists;
END$$
DELIMITER ;




-- ----------------------------------------- login user ---------------------------------------
DELIMITER $$
CREATE PROCEDURE login_user(user_email VARCHAR(100), user_password VARCHAR(100))
BEGIN
	DECLARE userExists TINYINT;
    SET userExists = validate_user(user_email, user_password);
	
    IF userExists THEN
		SELECT id, nome, email FROM usuario
        WHERE email = user_email AND user_password = senha;
	ELSE 
		SELECT "Senha ou Email Inválido";
    END IF;
END$$
DELIMITER ;

CALL login_user('lucaslameira@gmail.com', '123456');


-- ------------------------------Resgiste a new user--------------------------------------
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

select * from usuario;