SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES';

DROP FUNCTION IF EXISTS isState;

DELIMITER //

CREATE FUNCTION isState ( stringparam VARBINARY(255)) 
RETURNS TINYINT UNSIGNED 
DETERMINISTIC
NO SQL
SQL SECURITY DEFINER
COMMENT 'Returns 1 if stringparam is an American state code, 0 otherwise.  Note that the state code has to be in **UPPERCASE** (v1.00)'

/*****************************************************************************
*
* DESCRIPTION:	Returns 1 if <stringparam> is an American state code, 0 otherwise
* 
* AUTHOR:		Benoît St-Jean <bstjean@yahoo.com>
* URL:		 	http://www.endormitoire.wordpress.com
* VERSION: 		1.00
*
* USAGE:		SELECT isState('VT');
* RESULT: 		1
*
* PARAMETERS:	stringparam 	2 character abbreviation of the state (in uppercase)
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

RETURN BINARY stringparam IN (	'AL', 'AK', 'AZ', 'AR', 'CA', 'CO', 'CT', 'DE', 'FL', 'GA', 
								'HI', 'ID', 'IL', 'IN', 'IA', 'KS', 'KY', 'LA', 'ME', 'MD', 
								'MA', 'MI', 'MN', 'MS', 'MO', 'MT', 'NE', 'NV', 'NH', 'NJ', 
								'NM', 'NY', 'NC', 'ND', 'OH', 'OK', 'OR', 'PA', 'RI', 'SC', 
								'SD', 'TN', 'TX', 'UT', 'VT', 'VA', 'WA', 'WV', 'WI', 'WY');

END
//

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
