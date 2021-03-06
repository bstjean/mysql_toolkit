SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES';

DROP FUNCTION IF EXISTS rot47;

DELIMITER //

CREATE FUNCTION rot47 (stringParam VARCHAR(255)) 
RETURNS VARCHAR(255)
DETERMINISTIC
NO SQL
SQL SECURITY DEFINER
COMMENT 'Encodes/decodes a string with the ROT47 substitution cipher (v1.00)'

/*****************************************************************************
*
* DESCRIPTION:	Encodes/decodes a string with the ROT47 substitution cipher (v1.00)
* 
* AUTHOR:		Benoît St-Jean <bstjean@yahoo.com>
* URL:		 	http://www.endormitoire.wordpress.com
* VERSION: 		1.00
*
* USAGE:		SELECT rot47('The Quick Brown Fox Jumps Over The Lazy Dog.');
* RESULT: 		'%96 "F:4< qC@H? u@I yF>AD ~G6C %96 {2KJ s@8]'
*
* PARAMETERS:	stringParam		string that is to be encrypted/decrypted with ROT47
*
* RETURN:		VARCHAR(255)
*
* NOTES:		https://en.wikipedia.org/wiki/ROT13
*		
******************************************************************************/

BEGIN
	DECLARE newString VARCHAR(255);
	DECLARE plainAlbhabet, shiftedAlphabet VARCHAR(97);
	DECLARE charIndex, stringSize, plainCharIndex TINYINT UNSIGNED;
	DECLARE currentChar VARCHAR(1);
	
	SET plainAlbhabet =   'PQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~!\"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNO';
	SET shiftedAlphabet = '!\"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~';
	
	SET stringSize = CHAR_LENGTH(stringParam);
	SET newString = '';
	
	SET charIndex = 1;
	
	WHILE (charIndex <= stringSize) DO
		SET currentChar = SUBSTRING(stringParam, charIndex, 1);
		SET plainCharIndex = LOCATE(BINARY currentChar, plainAlbhabet);
		
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

