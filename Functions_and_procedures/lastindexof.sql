SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES';

DROP FUNCTION IF EXISTS lastIndexOf;

DELIMITER //

CREATE FUNCTION lastIndexOf ( stringparam VARBINARY(255), targetstr VARBINARY(255)) 
RETURNS TINYINT UNSIGNED 
DETERMINISTIC
NO SQL
SQL SECURITY DEFINER
COMMENT 'Returns the position of the last occurrence of substring targetstr in string stringparam (v1.01)'

/*****************************************************************************
*
* DESCRIPTION:	Returns the position of the last occurrence of substring targetstr in string stringparam (or 0 if not found or stringparam is null)
* 
* AUTHOR:		Benoît St-Jean <bstjean@yahoo.com>
* URL:		 	http://www.endormitoire.wordpress.com
* VERSION: 		1.01
*
* USAGE:		SELECT lastIndexOf('ab00ab00ab00', 'ab');
* RESULT: 		9
*
* PARAMETERS:	stringparam 	string to be searched
*				targetstr		string we are trying to locate in stringparam				
*
* RETURN:		TINYINT UNSIGNED
*
* NOTES:		This function is CASE SENSITIVE !!!
*		
******************************************************************************/

BEGIN

DECLARE idx TINYINT UNSIGNED;


IF stringparam IS NULL THEN
	RETURN 0;
ELSEIF targetstr IS NULL THEN
	RETURN 0;
ELSEIF stringparam = '' THEN
	RETURN 0;
ELSEIF targetstr = '' THEN
	RETURN 0;
END IF;

SET idx = CHAR_LENGTH(stringparam) - CHAR_LENGTH(targetstr) + 1;

WHILE idx > 0 DO
	IF LOCATE(targetstr, stringparam, idx) <> 0 THEN
		RETURN idx;
	ELSE
		SET idx = idx - 1;
	END IF;
END WHILE;

RETURN 0;
END //

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
