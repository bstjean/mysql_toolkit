SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES';

DROP FUNCTION IF EXISTS removeAllChars;

DELIMITER //

CREATE FUNCTION removeAllChars (stringParam VARCHAR(255), removeCharString VARCHAR(255)) 
RETURNS VARCHAR(255)
DETERMINISTIC
NO SQL
SQL SECURITY DEFINER
COMMENT 'Removes all characters in <removeCharString> from <stringParam> (v1.00)'

/*****************************************************************************
*
* DESCRIPTION:	Removes all characters in <removeCharString> from <stringParam>.
* 
* AUTHOR:		Benoît St-Jean <bstjean@yahoo.com>
* URL:		 	http://www.endormitoire.wordpress.com
* VERSION: 		1.00
*
* USAGE:		SELECT removeAllChars('This punctuation, quite frankly, is annoying! Do you think?', ',!?');
* RESULT: 		'This punctuation quite frankly is annoying Do you think'
*
* PARAMETERS:	stringParam	: string in which removed all the specified characters
*
* RETURN:		VARCHAR(255)
*
* NOTES:								
*		
******************************************************************************/

BEGIN
	DECLARE newString VARCHAR(255);
	DECLARE strLength TINYINT UNSIGNED;
	DECLARE idx TINYINT UNSIGNED;
	DECLARE chr CHAR(1);

	SET newString = stringParam;
	SET strLength = CHAR_LENGTH(removeCharString);

	SET idx = 1;
	
	WHILE idx <= strLength DO
		SET chr = SUBSTRING(removeCharString, idx, 1);
		SET newString = REPLACE(newString, chr, '');
		SET idx = idx + 1;
	END WHILE;
	
RETURN newString;
END
//

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;

