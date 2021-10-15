SET GLOBAL log_bin_trust_function_creators = 1;

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


-- login user
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
select * from usuario;
describe usuario;