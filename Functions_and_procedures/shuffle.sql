SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES';

DROP FUNCTION IF EXISTS shuffle;

DELIMITER //

CREATE FUNCTION shuffle (stringParam VARCHAR(255)) 
RETURNS VARCHAR(255)
NOT DETERMINISTIC
NO SQL
SQL SECURITY DEFINER
COMMENT 'Randomly shuffle the characters in the string (v1.00)'

/*****************************************************************************
*
* DESCRIPTION:	Randomly shuffles the characters in the string and returns 
				that new string
* 
* AUTHOR:		Benoît St-Jean <bstjean@yahoo.com>
* URL:		 	http://www.endormitoire.wordpress.com
* VERSION: 		1.00
*
* USAGE:		SELECT shuffle('1234567890');
* RESULT: 		Not deterministic but something like '3105796428'
*
* PARAMETERS:	stringParam		string that needs to be randomly shuffled
*
* RETURN:		VARCHAR(255)
*
* NOTES:		Uses the Fisher-Yates (aka Knuth shuffle) algorithm to
*				randomly shuffle the characters of the string <stringParam>
*
*				https://en.wikipedia.org/wiki/Fisher%E2%80%93Yates_shuffle
*		
******************************************************************************/

BEGIN
	DECLARE newString VARCHAR(255);
	DECLARE randomIndex, charIndex TINYINT UNSIGNED;
	DECLARE i, j VARCHAR(1);
	
	SET newString = stringParam;
	SET charIndex = CHAR_LENGTH(stringParam);
	
	WHILE charIndex > 1 DO
		/* Get an index between 1 and <charIndex> for the next character to swap */
		SET randomIndex = FLOOR((RAND() * charIndex) + 1);
		
		/* Swap i and j characters */
		SET i = SUBSTRING(newString, randomIndex, 1);
		SET j = SUBSTRING(newString, charIndex, 1);
		SET newString = INSERT(newString, charIndex, 1, i);
		SET newString = INSERT(newString, randomIndex, 1, j);
		
		SET charIndex = charIndex - 1;
	END WHILE;
	
RETURN newString;
END
//

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;

