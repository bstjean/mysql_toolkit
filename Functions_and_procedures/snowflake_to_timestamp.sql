SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES';

DROP FUNCTION IF EXISTS snowflake_to_timestamp;

DELIMITER //


CREATE FUNCTION snowflake_to_timestamp (tweetid BIGINT) 
RETURNS CHAR(26)
DETERMINISTIC
NO SQL
SQL SECURITY DEFINER
COMMENT 'Extracts the creation time (timestamp) of a snowflake. (v1.01)'

/*****************************************************************************
*
* DESCRIPTION:	Extracts the creation time (timestamp) of a snowflake.
*				Snowflakes are also known as Twitter ids, e.g tweet id 
* 
* AUTHOR:		Benoît St-Jean <bstjean@yahoo.com>
* URL:		 	http://www.endormitoire.wordpress.com
* VERSION: 		1.01
*
* USAGE:		SELECT snowflake_to_timestamp(1187543164111990785);
* RESULT: 		2019-10-25 01:35:28.466
*
* PARAMETERS:	tweetid		bigint that represents the id of a tweet
*
* RETURN:		CHAR(23)
*
* NOTES:		Returned timestamp is ALWAYS in UTC time !
*
*				For the snowflake format, see:
*				https://github.com/twitter-archive/snowflake/tree/snowflake-2010
*
*				The example provided is one of my own tweets :
*
*				https://twitter.com/BenLeChialeux/status/1187543164111990785
*		
******************************************************************************/


BEGIN
	DECLARE timestampResult CHAR(26);
	
	SET timestampResult = DATE_FORMAT(FROM_UNIXTIME(((tweetid >> 22) + 1288834974657) / 1000.0), '%Y-%m-%d %H:%i:%S.%f');
	RETURN LEFT(CONVERT_TZ(timestampResult, @@session.time_zone, '+00:00'), 23); 

END
//

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;


