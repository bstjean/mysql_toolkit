SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES';

DROP FUNCTION IF EXISTS ascii_sort;

DELIMITER //

CREATE FUNCTION ascii_sort (stringParam VARCHAR(255)) 
RETURNS VARCHAR(255)
DETERMINISTIC
NO SQL
SQL SECURITY DEFINER
COMMENT 'Sorts a string based on the ASCII value of each character (v1.00)'

/*****************************************************************************
*
* DESCRIPTION:	Sorts the string <stringParam> based on the ASCII value of each character (v1.00)
* 
* AUTHOR:		Benoît St-Jean <bstjean@yahoo.com>
* URL:		 	http://www.endormitoire.wordpress.com
* VERSION: 		1.00
*
* USAGE:		SELECT ascii_sort('hsizbap');
* RESULT: 		'abhipsz'
*
* PARAMETERS:	stringParam		string that needs to be ascii sorted
*
* RETURN:		VARCHAR(255)
*
* NOTES:		https://en.wikipedia.org/wiki/Selection_sort
*		
******************************************************************************/

BEGIN
	DECLARE newString VARCHAR(255);
	DECLARE n TINYINT UNSIGNED;
	DECLARE i TINYINT UNSIGNED;
	DECLARE j TINYINT UNSIGNED;
	DECLARE min_idx TINYINT UNSIGNED;
	DECLARE str_j CHAR(1);
	DECLARE str_i CHAR(1);
	DECLARE str_min_idx CHAR(1);
	DECLARE temp CHAR(1);
	
	SET newString = stringParam;
	SET n = CHAR_LENGTH(stringParam);
	
	SET i = 1;
	
	WHILE i < n DO
		SET min_idx = i;
		SET j = i + 1;
		
		/* Find the minimum element in the unsorted part of the string */
		WHILE j <= n DO
			SET str_j = MID(newString, j, 1);
			SET str_min_idx = MID(newString, min_idx, 1);
			
			IF ASCII(str_j) < ASCII(str_min_idx) THEN
				SET min_idx = j;
			END IF;
		
			SET j = j + 1;
		END WHILE;

		/* Swap the element found with the first one in the unsorted remaining part of the string */
		SET str_i = MID(newString, i, 1);
		SET temp = MID(newString, min_idx, 1);
		
		SET newString = INSERT(newString, min_idx, 1, arr_i);
		SET newString = INSERT(newString, i, 1, temp);
		
		
		SET i = i + 1;
	END WHILE;
	
RETURN newString;
END
//

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;

