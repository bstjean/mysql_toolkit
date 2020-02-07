SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES';

DROP FUNCTION IF EXISTS randomGaussian;

DELIMITER //

CREATE FUNCTION randomGaussian (mu DOUBLE, sigma DOUBLE) 
RETURNS DOUBLE
NOT DETERMINISTIC
NO SQL
SQL SECURITY DEFINER
COMMENT 'Returns a random number based on a normal (gaussian) distribution. (v1.00)'

/*****************************************************************************
*
* DESCRIPTION:	Returns a random number based on a normal (gaussian) distribution.
* 
* AUTHOR:		Benoît St-Jean <bstjean@yahoo.com>
* URL:		 	http://www.endormitoire.wordpress.com
* VERSION: 		1.00
*
* USAGE:		SELECT randomGaussian(12.5, 3.2216);
* RESULT: 		10.284951047046617 (this function is NOT deterministic!)
*
* PARAMETERS:	mu 		mean of the gaussian distribution
*				sigma	standard deviation of the gaussian distribution
*
* RETURN:		DOUBLE
*
* NOTES:		n/a
*		
******************************************************************************/
BEGIN 
	DECLARE x DOUBLE;
	DECLARE v1 DOUBLE;
	DECLARE v2 DOUBLE;
  
	IF (mu IS NULL) THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mean must not be NULL';
	ELSEIF (sigma IS NULL) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Standard deviation must not be NULL';
    END IF;
  
	SET v1 := RAND();
	SET v2 := RAND();

	SET x := SQRT(-2.0 * LOG(v1)) * COS(2.0 * PI() * v2);
	RETURN (mu + (sigma * x));
	
END//

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
