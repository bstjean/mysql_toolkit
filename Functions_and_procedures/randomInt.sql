SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES';

DROP FUNCTION IF EXISTS randomInt;

DELIMITER //

CREATE FUNCTION randomInt (fromInt INT UNSIGNED, toInt INT UNSIGNED) 
RETURNS INT UNSIGNED 
NOT DETERMINISTIC
NO SQL
SQL SECURITY DEFINER
COMMENT 'Returns a random positive integer between <fromInt> and <toInt> *inclusively* (v1.00)'

/*****************************************************************************
*
* DESCRIPTION:	Returns a random positive integer between <fromInt> and <toInt> *inclusively*
* 
* AUTHOR:		Benoît St-Jean <bstjean@yahoo.com>
* URL:		 	http://www.endormitoire.wordpress.com
* VERSION: 		1.00
*
* USAGE:		SELECT randomInt(1, 10);
* RESULT: 		7 (this function is NOT deterministic!)
*
* PARAMETERS:	fromInt 	minimum integer value [0, 4294967295]
*				toInt		maximum integer value [0, 4294967295]
*
* RETURN:		INT UNSIGNED
*
* NOTES:		n/a
*		
******************************************************************************/
BEGIN 

	IF (fromInt IS NULL) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '<fromInt> parameter must not be NULL';
	ELSEIF (toInt IS NULL) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '<toInt> parameter must not be NULL';
	ELSEIF NOT (fromInt < toInt) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Parameter <fromInt> must be smallter than <toInt>';
    END IF;
	

	RETURN FLOOR(RAND() * (toInt - fromInt + 1)) + fromInt;
	
END//

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
