SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES';

DROP FUNCTION IF EXISTS collapse_spaces;

DELIMITER //

CREATE FUNCTION collapse_spaces (stringParam VARCHAR(255)) 
RETURNS VARCHAR(255)
DETERMINISTIC
NO SQL
SQL SECURITY DEFINER
COMMENT 'Replaces multiple spaces with a single space (v1.00)'

/*****************************************************************************
*
* DESCRIPTION:	Replaces multiple spaces with a single space
* 
* AUTHOR:		Benoît St-Jean <bstjean@yahoo.com>
* URL:		 	http://www.endormitoire.wordpress.com
* VERSION: 		1.00
*
* USAGE:		SELECT collapse_spaces('   this    is        a  string    ');
* RESULT: 		' this is a string '
*
* PARAMETERS:	stringParam		string that needs to be collapsed
*
* RETURN:		VARCHAR(255)
*
* NOTES:		Similar to collapse_blanks but optimized for SPACES only!
*		
******************************************************************************/

BEGIN
	DECLARE newString VARCHAR(255);
	DECLARE hasChanged BOOLEAN;
	DECLARE oldLength TINYINT UNSIGNED;
	
	SET hasChanged = TRUE;
	SET newString = stringParam;
	SET oldLength = CHAR_LENGTH(stringParam);
	
	WHILE hasChanged DO
		SET newString = REPLACE(newString, '  ', ' ');
		SET hasChanged = (oldLength != CHAR_LENGTH(newString));
		SET oldLength = CHAR_LENGTH(newString);
	END WHILE;
	
RETURN newString;
END
//

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;

