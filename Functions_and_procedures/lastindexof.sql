SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES';

DROP FUNCTION IF EXISTS lastIndexOf;

DELIMITER //

CREATE FUNCTION lastIndexOf ( stringparam VARBINARY(255), targetstr VARBINARY(255)) 
RETURNS TINYINT UNSIGNED 
DETERMINISTIC
NO SQL
SQL SECURITY DEFINER
COMMENT 'Returns the position of the last occurrence of substring targetstr in string stringparam (v1.00)'

/*****************************************************************************
*
* DESCRIPTION:	Returns the position of the last occurrence of substring targetstr in string stringparam (or 0 if not found or stringparam is null)
* 
* AUTHOR:		Benoît St-Jean <bstjean@yahoo.com>
* URL:		 	http://www.endormitoire.wordpress.com
* VERSION: 		1.00
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
DECLARE foundAnother TINYINT UNSIGNED;
DECLARE oldIndex TINYINT UNSIGNED;
DECLARE newIndex TINYINT UNSIGNED;

SET foundAnother = 1;
SELECT LOCATE(targetstr, stringparam) INTO oldIndex;

IF (oldIndex IS NULL) THEN
	RETURN 0;
ELSEIF (oldIndex = 0) THEN 
	RETURN 0;
END IF;


WHILE foundAnother DO
	SET newIndex = LOCATE(targetstr, stringparam, oldIndex+1);
	IF newIndex > oldIndex THEN
		SET oldIndex = newIndex;
	ELSE
		SET foundAnother = 0;
	END IF;
END WHILE;

RETURN oldIndex;
END //

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
