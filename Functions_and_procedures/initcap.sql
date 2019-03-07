SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES';

DROP FUNCTION IF EXISTS initcap;

DELIMITER //

CREATE FUNCTION initcap(stringParam VARCHAR(255)) 
RETURNS VARCHAR(255)
DETERMINISTIC
NO SQL
SQL SECURITY DEFINER
COMMENT 'Returns a character string with the first letter of each word converted to uppercase v1.00'

/*****************************************************************************
*
* DESCRIPTION:	Returns a character string with the first letter of each word converted to uppercase.
*				This function EXACTLY mimics INITCAP of Oracle.
* 
* AUTHOR:		Benoît St-Jean <bstjean@yahoo.com>
* URL:		 	http://www.endormitoire.wordpress.com
* VERSION: 		1.00
*
* USAGE:		SELECT initcap('this is a string');  => 'This Is A String'
*				SELECT initcap('THIS IS A STRING');  => 'This Is A String'
*				SELECT initcap('this_is-a*string');  => 'This_Is-A*String'
*				SELECT initcap('à étienne');  => 'À Étienne'
*				SELECT initcap('');  => ''
*               SELECT initcap(NULL);  => NULL
*               SELECT initcap('this\tis\tdÉjÀ vu for étienne');  => 'This  Is      Déjà Vu For Étienne'
*
* PARAMETERS:	stringParam	:	string that needs to be title cased
*
* RETURN:		VARCHAR(255)
*
* NOTES:		EVERY character that is NOT alphanumeric is considered as a SEPARATOR!  This function
*				mimics INITCAP of Oracle in every aspect.
*		
******************************************************************************/

BEGIN
	DECLARE stringSize, charIndex TINYINT UNSIGNED;
	DECLARE currentChar, previousChar, newChar VARCHAR(1);
	DECLARE newString VARCHAR(255);
	DECLARE previousNotAlphanumeric BOOLEAN;
	DECLARE alphaNumeric VARCHAR(118);
	
	SET stringSize = CHAR_LENGTH(stringParam);

	SET charIndex = 2;
	SET alphaNumeric = 'abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZàáâãäåæçèéêëìíîïðñòóôõöøùúûüÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜ';
	SET newString = CONCAT('', UPPER(SUBSTRING(stringParam, 1, 1)));
	
	WHILE (charIndex <= stringSize) DO
		SET previousChar = SUBSTRING(stringParam, charIndex - 1, 1);
		SET currentChar = SUBSTRING(stringParam, charIndex, 1);
		SET newChar = LOWER(currentChar); 
		SET previousNotAlphanumeric = ((LOCATE(previousChar, alphaNumeric)) = 0);  
		
		IF previousNotAlphanumeric THEN
			SET newChar = UPPER(currentChar);
		END IF;
		
		SET newString = CONCAT(newString, newChar);
		SET charIndex = charIndex + 1;
	END WHILE;


RETURN newString;
END
//

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;

