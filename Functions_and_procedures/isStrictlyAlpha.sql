SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES';

DROP FUNCTION IF EXISTS isStrictlyAlpha;

DELIMITER //

CREATE FUNCTION isStrictlyAlpha (stringparam VARBINARY(255)) 
RETURNS TINYINT UNSIGNED 
DETERMINISTIC
NO SQL
SQL SECURITY DEFINER
COMMENT 'Returns 1 if stringparam only contains [A-Z, a-z] characters, 0 otherwise (v1.00)'

/*****************************************************************************
*
* DESCRIPTION:	Returns 1 if stringparam only contains [A-Z, a-z] characters, 0 otherwise (or stringparam is null or empyty)
* 
* AUTHOR:		Benoît St-Jean <bstjean@yahoo.com>
* URL:		 	http://www.endormitoire.wordpress.com
* VERSION: 		1.00
*
* USAGE:		SELECT isStrictlyAlpha('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ');
* RESULT: 		1
*
* PARAMETERS:	stringparam 	string to be searched
*
* RETURN:		TINYINT UNSIGNED
*
* NOTES:		n/a
*		
******************************************************************************/
BEGIN

	DECLARE stringLength TINYINT UNSIGNED;
	DECLARE ch BINARY(1);
	DECLARE idx TINYINT UNSIGNED;

	SET stringLength = CHAR_LENGTH(stringparam);
	SET idx = 1;

	/* NULL and empty strings are NOT strictly alphabetic */
	IF (stringparam IS NULL OR (stringLength = 0)) THEN
		RETURN 0;
	END IF;


	WHILE (idx <= stringLength) DO
		SET ch = SUBSTRING(stringparam, idx, 1);
	
		IF INSTR('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', ch) = 0 THEN  
			RETURN 0;
		ELSE
			SET idx = idx + 1;
		END IF;
	END WHILE;

	RETURN 1;
END//

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
