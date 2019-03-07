SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES';

DROP FUNCTION IF EXISTS occurrences;

DELIMITER //

CREATE FUNCTION occurrences ( sourceString VARBINARY(255), searchString VARBINARY(255)) 
RETURNS TINYINT UNSIGNED 
DETERMINISTIC
NO SQL
SQL SECURITY DEFINER
COMMENT 'Returns the number of occurrences of <searchString> inside <sourceString> (v1.00)'

/*****************************************************************************
*
* DESCRIPTION:	Returns the number of occurrences of <searchString> inside <sourceString>
* 
* AUTHOR:		Benoît St-Jean <bstjean@yahoo.com>
* URL:		 	http://www.endormitoire.wordpress.com
* VERSION: 		1.00
*
* USAGE:		SELECT occurrences('the fourth thing that they thought', 'th');
* RESULT: 		6
*
* PARAMETERS:	sourceString	source string that is to be searched
*				searchString	string for which we count the occurrences
*
* RETURN:		TINYINT UNSIGNED
*
* NOTES:		This function is CASE SENSITIVE !!!
*		
******************************************************************************/

BEGIN
DECLARE occ TINYINT UNSIGNED;

SET occ = FLOOR(( CHAR_LENGTH(sourceString) - CHAR_LENGTH(REPLACE(sourceString, searchString, '')) ) / (CHAR_LENGTH(searchString)));

RETURN occ;
END
//

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;

