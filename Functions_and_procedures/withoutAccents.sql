SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES';

DROP FUNCTION IF EXISTS withoutAccents;

DELIMITER //

CREATE FUNCTION withoutAccents (stringparam VARBINARY(255)) 
RETURNS VARBINARY(255)
DETERMINISTIC
NO SQL
SQL SECURITY DEFINER
COMMENT 'Returns a copy of stringparam with all accentuated characters replaced by their "plain" alphabetic equivalent (v1.00)'

/*****************************************************************************
*
* DESCRIPTION:	Returns a copy of stringparam with all accentuated characters replaced by their "plain" alphabetic equivalent
* 
* AUTHOR:		Benoît St-Jean <bstjean@yahoo.com>
* URL:		 	http://www.endormitoire.wordpress.com
* VERSION: 		1.00
*
* USAGE:		SELECT withoutAccents ('Benoît où étais-tu avec Ève et François si tôt?');
* RESULT: 		'Benoit ou etais-tu avec Eve et Francois si tot?'
*
* PARAMETERS:		stringparam 	string from which we remove all accentuated characters and replace them by "normal" letters				
*
* RETURN:		VARBINARY(255)
*
* NOTES:		This function is EXTREMELY slow !  You have been warned!
*		
******************************************************************************/

BEGIN
	
    DECLARE newString VARBINARY(255);
    DECLARE idx_accent TINYINT UNSIGNED;
    DECLARE idx_plain TINYINT UNSIGNED;
    DECLARE accentString VARBINARY(1662);
    DECLARE plainString VARBINARY(975);
    DECLARE accentChar VARBINARY(6);
    DECLARE plainChar VARBINARY(2);   /* Some accentuated chars are replaced by TWO plain characters (e.g. ae & oe in French) */

    SET newString = stringparam;

    SET accentString = 'Æ,æ,Ǣ,ǣ,Ǽ,ǽ,Á,á,Â,â,À,à,Ȁ,ȁ,Ă,ă,Å,å,Ä,ä,Ā,ā,Ǟ,ǟ,Ã,ã,Ą,ą,Ą̊,ą̊,Ḁ,ḁ,A͗,ẚ,Ⱥ,ⱥ,Ḃ,ḃ,Ḅ,ḅ,Ḇ,ḇ,Ƀ,ƀ,Ɓ,ɓ,Ć,ć,Ĉ,ĉ,Č,č,Ç,ç,Ḉ,ḉ,Ċ,ċ,Ƈ,ƈ,Ȼ,ȼ,Ɗ,ɗ,Ḓ,ḓ,Ď,ď,Ḋ,ḋ,Ḍ,ḍ,Ḏ,ḏ,Ḑ,ḑ,Đ,đ,Ð,ð,Ɖ,ɖ,Ḏ,ḏ,É,é,Ê,ê,È,è,Ȅ,ȅ,Ě,ě,Ë,ë,Ē,ē,Ẽ,ẽ‌,Ĕ,ĕ,Ę,ę,Ė,ė,Ẹ,ẹ,Ȇ,ȇ,Ḕ,ḕ,Ḗ,ḗ,Ḙ,ḙ,Ḛ,ḛ,Ḝ,ḝ,Ɇ,ɇ,Ḟ,ḟ,Ƒ,ƒ,Ǵ,ǵ,Ĝ,ĝ,Ǧ,ǧ,Ğ,ğ,Ġ,ġ,Ģ,ģ,Ɠ,ɠ,Ḡ,ḡ,Ǥ,ǥ,Ĥ,ĥ,Ȟ,ȟ,Ḧ,ḧ,Ḣ,ḣ,Ḥ,ḥ,H̱,ẖ,Ḩ,ḩ,Ḫ,ḫ,Ħ,ħ,Ⱨ,ⱨ,İ,i,I,ı,Í,í,Î,î,Ì,ì,Ȉ,ȉ,Ï,ï,Ḯ,ḯ,Ī,ī,Ĩ,ĩ,Į,į,Ị,ị,Ḭ,ḭ,Ĵ,ĵ,J̌,ǰ,Ɉ,ɉ,Ḱ,ḱ,Ǩ,ǩ,Ķ,ķ,Ḳ,ḳ,Ḵ,ḵ,Ƙ,ƙ,Ⱪ,ⱪ,Ĺ,ĺ,Ł,ł,Ḽ,ḽ,Ľ,ľ,Ļ,ļ,Ḷ,ḷ,Ḹ,ḹ,Ḻ,ḻ,Ƚ,ƚ,Ɫ,ɫ,Ⱡ,ⱡ,Ḿ,ḿ,Ṁ,ṁ,Ṃ,ṃ,Ŋ,ŋ,Ń,ń,Ǹ,ǹ,Ñ,ñ,Ṋ,ṋ,Ň,ň,Ṅ,ṅ,Ṇ,ṇ,Ṉ,ṉ,ŉ,N̈,n̈,Ņ,ņ,Ó,ó,Ő,ő,Ô,ô,Ò,ò,Ȍ,ȍ,Ŏ,ŏ,Ȯ,ȯ,Ȱ,ȱ,Ö,ö,Ȫ,ȫ,Ō,ō,Ṓ,ṓ,Ṑ,ṑ,Õ,õ,Ṍ,ṍ,Ṏ,ṏ,Ȭ,ȭ,Ø,ø,Ǿ,ǿ,Ǫ,ǫ,Ǭ,ǭ,Ọ,ọ,Ȏ,ȏ,Ơ,ơ,Ṕ,ṕ,Ṗ,ṗ,Ƥ,ƥ,Ᵽ,ᵽ,Ꝗ,ꝗ,Ŕ,ŕ,Ȑ,ȑ,Ř,ř,Ŗ,ŗ,Ṙ,ṙ,Ṛ,ṛ,Ṝ,ṝ,Ṟ,ṟ,Ɍ,ɍ,Ɽ,ɽ,Ś,ś,Ṥ,ṥ,Ŝ,ŝ,Š,š,Ṧ,ṧ,Ş,ş,Ș,ș,Ṡ,ṡ,Ṣ,ṣ,Ṩ,ṩ,Ť,ť,Ṱ,ṱ,T̈,ẗ,Ţ,ţ,Ț,ț,Ŧ,ŧ,Ṫ,ṫ,Ṭ,ṭ,Ṯ,ṯ,Ⱦ,ⱦ,Ú,ú,Ù,ù,Û,û,Ŭ,ŭ,Ư,ư,Ű,ű,Ü,ü,Ū,ū,Ṻ,ṻ,Ų,ų,Ů,ů,Ũ,ũ,Ṹ,ṹ,Ụ,ụ,Ṳ,ṳ,Ṵ,ṵ,Ṷ,ṷ,Ʉ,ʉ,Ṽ,ṽ,Ṿ,ṿ,Ʋ,ʋ,Ỽ,ỽ,Ẃ,ẃ,Ŵ,ŵ,Ẁ,ẁ,Ẅ,ẅ,W̊,ẘ,Ẇ,ẇ,Ẉ,ẉ,Ⱳ,ⱳ,X̂,x̂,Ẍ,ẍ,Ẋ,ẋ,Ƴ,ƴ,Ý,ý,Ŷ,ŷ,Ỳ,ỳ,Ÿ,ÿ,Ȳ,ȳ,Ỹ,ỹ,Y̊,ẙ,Ẏ,ẏ,Y̨,y̨,Ɏ,ɏ,Ỿ,ỿ,Ź,ź,Ẑ,ẑ,Ž,ž,Ż,ż,Ẓ,ẓ,Ẕ,ẕ,Ƶ,ƶ,Ȥ,ȥ';
    SET plainString = 'AE,ae,AE,ae,AE,ae,A,a,A,a,A,a,A,a,A,a,A,a,A,a,A,a,A,a,A,a,A,a,A,a,A,a,A,a,A,a,B,b,B,b,B,b,B,b,B,b,C,c,C,c,C,c,C,c,C,c,C,c,C,c,C,c,D,d,D,d,D,d,D,d,D,d,D,d,D,d,D,d,D,d,D,d,D,d,E,e,E,e,E,e,E,e,E,e,E,e,E,e,E,e,E,e,E,e,E,e,E,e,E,e,E,e,E,e,E,e,E,e,E,e,E,e,F,f,F,f,G,g,G,g,G,g,G,g,G,g,G,g,G,g,G,g,G,g,H,h,H,h,H,h,H,h,H,h,H,h,H,h,H,h,H,h,H,h,I,i,I,i,I,i,I,i,I,i,I,i,I,i,I,i,I,i,I,i,I,i,I,i,I,i,J,j,J,j,J,j,K,k,K,k,K,k,K,k,K,k,K,k,K,k,L,l,L,l,L,l,L,l,L,l,L,l,L,l,L,l,L,l,L,l,L,l,M,m,M,m,M,m,N,n,N,n,N,n,N,n,N,n,N,n,N,n,N,n,N,n,n,N,n,N,n,O,o,O,o,O,o,O,o,O,o,O,o,O,o,O,o,O,o,O,o,O,o,O,o,O,o,O,o,O,o,O,o,O,o,O,o,O,o,O,o,O,o,O,o,O,o,O,o,P,p,P,p,P,p,P,p,Q,q,R,r,R,r,R,r,R,r,R,r,R,r,R,r,R,r,R,r,R,r,S,s,S,s,S,s,S,s,S,s,S,s,S,s,S,s,S,s,S,s,T,t,T,t,T,t,T,t,T,t,T,t,T,t,T,t,T,t,T,t,U,u,U,u,U,u,U,u,U,u,U,u,U,u,U,u,U,u,U,u,U,u,U,u,U,u,U,u,U,u,U,u,U,u,U,u,V,v,V,v,V,v,V,v,W,w,W,w,W,w,W,w,W,w,W,w,W,w,W,w,X,x,X,x,X,x,Y,y,Y,y,Y,y,Y,y,Y,y,Y,y,Y,y,Y,y,Y,y,Y,y,Y,y,Y,y,Z,z,Z,z,Z,z,Z,z,Z,z,Z,z,Z,z,Z,z';

    SET idx_accent = LOCATE(',', accentString);
    SET idx_plain = LOCATE(',', plainString);


    WHILE (idx_accent > 0) DO

        /* Get the first element of both strings */
	SET accentChar = SUBSTRING(accentString, 1, idx_accent - 1);
        SET plainChar = SUBSTRING(plainString, 1, idx_plain - 1);
       
        /* Replace the accentuated char with its plain equivalent */ 
        SET newString = REPLACE(newString, accentChar, plainChar);
        
        /* Remove the first element of both strings */
        SET accentString = SUBSTRING(accentString, idx_accent + 1);
        SET plainString = SUBSTRING(plainString, idx_plain + 1);

	/* Cache the indices of the next comma to save 2 calls to the costly LOCATE function */
	SET idx_accent = LOCATE(',', accentString);
	SET idx_plain = LOCATE(',', plainString);

    END WHILE;

    RETURN newString;

END //

DELIMITER ;
