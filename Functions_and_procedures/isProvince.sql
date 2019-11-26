SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES';

DROP FUNCTION IF EXISTS isProvince;

DELIMITER //

CREATE FUNCTION isProvince ( stringparam VARBINARY(255)) 
RETURNS TINYINT UNSIGNED 
DETERMINISTIC
NO SQL
SQL SECURITY DEFINER
COMMENT 'Returns 1 if stringparam is a Canadian province code, 0 otherwise.  Note that the province code has to be in **UPPERCASE** (v1.00)'

/*****************************************************************************
*
* DESCRIPTION:	Returns 1 if <stringparam> is a Canadian province code, 0 otherwise
* 
* AUTHOR:		Benoît St-Jean <bstjean@yahoo.com>
* URL:		 	http://www.endormitoire.wordpress.com
* VERSION: 		1.00
*
* USAGE:		SELECT isProvince('SK');
* RESULT: 		1
*
* PARAMETERS:	stringparam 	2 character abbreviation of the province (in uppercase)
*
* RETURN:		TINYINT UNSIGNED
*
* NOTES:		This function is CASE SENSITIVE !!!
*		
******************************************************************************/

BEGIN

IF stringparam IS NULL THEN
	RETURN 0;
END IF;

RETURN BINARY stringparam IN ('AB', 'BC', 'MB', 'NB', 'NL', 'NS', 'NT', 'NU', 'ON', 'PE', 'QC', 'SK', 'YT');

END
//

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
