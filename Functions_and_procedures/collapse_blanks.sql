SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES';

DROP FUNCTION IF EXISTS collapse_blanks;

DELIMITER //

CREATE FUNCTION collapse_blanks (stringParam VARCHAR(255)) 
RETURNS VARCHAR(255)
DETERMINISTIC
NO SQL
SQL SECURITY DEFINER
COMMENT 'Replaces multiple blanks with a single space (v1.00)'

/*****************************************************************************
*
* DESCRIPTION:	Replaces multiple blanks with a single space.
				Blanks are: <space>|<Tab>|<FF>|<LF>|<CR>
* 
* AUTHOR:		Benoît St-Jean <bstjean@yahoo.com>
* URL:		 	http://www.endormitoire.wordpress.com
* VERSION: 		1.00
*
* USAGE:		SELECT collapse_blanks(' \t \n  this  \n\n  is     \r   a  string  \t\n\r  ');
* RESULT: 		' this is a string '
*
* PARAMETERS:	stringParam	: string in which we collapse blanks
*
* RETURN:		VARCHAR(255)
*
* NOTES:		Blanks are: <space> | <Tab> | <FF> | <LF> | <CR>							
*		
******************************************************************************/

BEGIN
	DECLARE newString VARCHAR(255);
	DECLARE hasChanged BOOLEAN;
	DECLARE oldLength TINYINT UNSIGNED;
	
	SET hasChanged = TRUE;
	SET newString = stringParam;
	SET oldLength = CHAR_LENGTH(stringParam);
	
	/* Replace CR, Tab, LF, FF by a single space */
	SET newString = REPLACE(newString, CHAR(13), ' ');
	SET newString = REPLACE(newString, CHAR(9), ' ');
	SET newString = REPLACE(newString, CHAR(10), ' ');
	SET newString = REPLACE(newString, CHAR(12), ' ');
	
	/* Collapse multiple spaces into one space */
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

