SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES';

DROP FUNCTION IF EXISTS rot5;

DELIMITER //

CREATE FUNCTION rot5 (stringParam VARCHAR(255)) 
RETURNS VARCHAR(255)
DETERMINISTIC
NO SQL
SQL SECURITY DEFINER
COMMENT 'Encodes/decodes a string with the ROT5 substitution cipher (v1.00)'

/*****************************************************************************
*
* DESCRIPTION:	Encodes/decodes a string with the ROT5 substitution cipher (v1.00)
* 
* AUTHOR:		Benoît St-Jean <bstjean@yahoo.com>
* URL:		 	http://www.endormitoire.wordpress.com
* VERSION: 		1.00
*
* USAGE:		SELECT rot5('Phone : 1-800-123-4567');  => 'Phone : 6-355-678-9012'
*
* PARAMETERS:	stringParam		string that is to be encrypted/decrypted with ROT5
*
* RETURN:		VARCHAR(255)
*
* NOTES:		https://en.wikipedia.org/wiki/ROT13
*		
******************************************************************************/

BEGIN
	DECLARE newString VARCHAR(255);
	DECLARE plainAlbhabet, shiftedAlphabet VARCHAR(10);
	DECLARE charIndex, stringSize, plainCharIndex TINYINT UNSIGNED;
	DECLARE currentChar VARCHAR(1);
	
	SET plainAlbhabet = '6789012345';
	SET shiftedAlphabet = '1234567890';
	
	SET stringSize = CHAR_LENGTH(stringParam);
	SET newString = '';
	
	SET charIndex = 1;
	
	WHILE (charIndex <= stringSize) DO
		SET currentChar = SUBSTRING(stringParam, charIndex, 1);
		SET plainCharIndex = LOCATE(currentChar, plainAlbhabet);
		
		IF (plainCharIndex > 0) THEN
			SET newString = CONCAT(newString, SUBSTRING(shiftedAlphabet, plainCharIndex, 1));
		ELSE
			SET newString = CONCAT(newString, currentChar);
		END IF;
		
		SET charIndex = charIndex + 1;
	END WHILE;	
	
RETURN newString;
END
//

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;

