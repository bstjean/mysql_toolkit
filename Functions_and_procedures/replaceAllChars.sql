SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES';

DROP FUNCTION IF EXISTS replaceAllChars;

DELIMITER //

CREATE FUNCTION replaceAllChars (stringParam VARCHAR(255), replaceCharString VARCHAR(255), repChar VARCHAR(1)) 
RETURNS VARCHAR(255)
DETERMINISTIC
NO SQL
SQL SECURITY DEFINER
COMMENT 'Replaces all characters in <replaceCharString> from <stringParam> by <repChar> (v1.00)'

/*****************************************************************************
*
* DESCRIPTION:	Replaces all characters in <replaceCharString> from <stringParam> by <repChar>.
* 
* AUTHOR:		Benoît St-Jean <bstjean@yahoo.com>
* URL:		 	http://www.endormitoire.wordpress.com
* VERSION: 		1.00
*
* USAGE:		SELECT replaceAllChars('Funky0way1to2punctuate8! Please3remove4all5those6numbers7!', '012345678', ' ');
* RESULT: 		'Funky way to punctuate ! Please remove all those numbers !'
*
* PARAMETERS:	stringParam	: string in which we want to removed all the specified characters
*				replaceCharString : string containing all the characters to be replaced
*				repChar : replacing character
*
* RETURN:		VARCHAR(255)
*
* NOTES:								
*		
******************************************************************************/

BEGIN
	DECLARE newString VARCHAR(255);
	DECLARE strLength TINYINT UNSIGNED;
	DECLARE idx TINYINT UNSIGNED;
	DECLARE chr CHAR(1);

	SET newString = stringParam;
	SET strLength = CHAR_LENGTH(replaceCharString);

	SET idx = 1;
	
	WHILE idx <= strLength DO
		SET chr = SUBSTRING(replaceCharString, idx, 1);
		SET newString = REPLACE(newString, chr, repChar);
		SET idx = idx + 1;
	END WHILE;
	
RETURN newString;
END
//

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;

