SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES';

DROP FUNCTION IF EXISTS to_roman;

DELIMITER //

CREATE FUNCTION to_roman (intParam SMALLINT UNSIGNED) 
RETURNS VARCHAR(255)
DETERMINISTIC
NO SQL
SQL SECURITY DEFINER
COMMENT 'Converts an integer to its Roman numeral representation (v1.00)'

/*****************************************************************************
*
* DESCRIPTION:	Converts an integer to its Roman numeral representation (v1.00)
* 
* AUTHOR:		Benoît St-Jean <bstjean@yahoo.com>
* URL:		 	http://www.endormitoire.wordpress.com
* VERSION: 		1.00
*
* USAGE:		SELECT to_roman(1999);  => 'MCMXCIX'
*				SELECT to_roman(3888);  => 'MMMDCCCLXXXVIII'
*
* PARAMETERS:	intParam	small integer between 1 and 3999
*
* RETURN:		VARCHAR(15)
*
* NOTES:		https://en.wikipedia.org/wiki/Roman_numerals
*		
******************************************************************************/

BEGIN
	DECLARE i, arabic, val SMALLINT UNSIGNED;
	DECLARE roman VARCHAR(2);
	DECLARE newString VARCHAR(15);
	
	IF NOT (intParam BETWEEN 1 AND 3999) THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'The argument of the function must be between 1 and 3999';
	END IF;
 
	SET i = 1;
	SET val = intParam;
	SET newString = '';
	
	WHILE i <= 13 DO
		CASE i
			WHEN 1 THEN SET arabic = 1000; SET roman = 'M';
			WHEN 2 THEN SET arabic = 900; SET roman = 'CM';
			WHEN 3 THEN SET arabic = 500; SET roman = 'D';
			WHEN 4 THEN SET arabic = 400; SET roman = 'CD';
			WHEN 5 THEN SET arabic = 100; SET roman = 'C';
			WHEN 6 THEN SET arabic = 90; SET roman = 'XC';
			WHEN 7 THEN SET arabic = 50; SET roman = 'L';
			WHEN 8 THEN SET arabic = 40; SET roman = 'XL';
			WHEN 9 THEN SET arabic = 10; SET roman = 'X';
			WHEN 10 THEN SET arabic = 9; SET roman = 'IX';
			WHEN 11 THEN SET arabic = 5; SET roman = 'V';
			WHEN 12 THEN SET arabic = 4; SET roman = 'IV';
			WHEN 13 THEN SET arabic = 1; SET roman = 'I';
		END CASE;
				
		WHILE (val >= arabic) DO
			SET newString = CONCAT(newString, roman);
			SET val = val - arabic;
		END WHILE;
		
		SET i = i + 1;
	END WHILE;

RETURN newString;
END
//

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;

