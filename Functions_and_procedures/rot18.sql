SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES';

DROP FUNCTION IF EXISTS rot18;

DELIMITER //

CREATE FUNCTION rot18 (stringParam VARCHAR(255)) 
RETURNS VARCHAR(255)
DETERMINISTIC
NO SQL
SQL SECURITY DEFINER
COMMENT 'Encodes/decodes a string with the ROT18 substitution cipher (v1.00)'

/*****************************************************************************
*
* DESCRIPTION:	Encodes/decodes a string with the ROT18 substitution cipher (v1.00)
* 
* AUTHOR:		Benoît St-Jean <bstjean@yahoo.com>
* URL:		 	http://www.endormitoire.wordpress.com
* VERSION: 		1.00
*
* USAGE:		SELECT rot18('Drinking 2 beers while listening to 2112!');
* RESULT: 		'Qevaxvat 7 orref juvyr yvfgravat gb 7667!'
*
* PARAMETERS:	stringParam		string that is to be encrypted/decrypted with ROT18
*
* RETURN:		VARCHAR(255)
*
* NOTES:		https://en.wikipedia.org/wiki/ROT13
*		
******************************************************************************/

BEGIN
	DECLARE newString VARCHAR(255);
	DECLARE plainAlbhabet, shiftedAlphabet VARCHAR(62);
	DECLARE charIndex, stringSize, plainCharIndex TINYINT UNSIGNED;
	DECLARE currentChar VARCHAR(1);
	
	SET plainAlbhabet =   'ABCDEFGHIJKLMabcdefghijklmNOPQRSTUVWXYZnopqrstuvwxyz6789012345';
	SET shiftedAlphabet = 'NOPQRSTUVWXYZnopqrstuvwxyzABCDEFGHIJKLMabcdefghijklm1234567890';
	
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

