# MySQL Toolkit

A collection of useful (I hope!) functions, stored procedures and SQL scripts to facilitate your job!

## Functions

**ascii_sort** : Sorts all characters of a string based on ASCII value.  
**collapse_blanks** : Replaces multiple blanks with a single space.  
**collapse_spaces** : Replaces multiple spaces with a single space.  
**initcap** : Returns a character string with the first letter of each word converted to uppercase. This function EXACTLY mimics INITCAP of Oracle.  
**isProvince** : Returns 1 if argument is a Canadian 2-letter province code, 0 otherwise.  
**isState** : Returns 1 if argument is an American 2-letter state code, 0 otherwise.  
**isStrictlyAlpha** : Returns 1 if the string only contains [A-Za-z] characters, 0 otherwise  
**lastindexof** : Returns the position of the last occurrence of a substring in a source string.  
**occurrences** : Returns the number of occurrences of a search string inside a source string.    
**removeAllChars : Removes all characters in a string from a source string.  
**replaceAllChars : Replaces all characters in a string by a single replacement character from  source string.  
**rot5** : Encodes/decodes a string with the ROT5 substitution cipher.    
**rot13** : Encodes/decodes a string with the ROT13 substitution cipher.  
**rot18** : Encodes/decodes a string with the ROT18 substitution cipher.  
**rot47** :Encodes/decodes a string with the ROT47 substitution cipher.  
**shuffle** : Randomly shuffle the characters of a string using the Fisher-Yates (aka Knuth shuffle) algorithm.  
**snowflake_to_timestamp** : Extracts the creation time (timestamp) of a snowflake.  
**to_roman** : Converts an integer to its Roman numeral representation.  
**withoutAccents** : Returns a string with all accentuated characters replaced by their "plain" character equivalent, [A-Za-z].  
BEWARE, this function is EXTREMELY slow!  You might want to filter out strings that do not need such transformation with the *isStrictlyAlpha* function!     
 

This **README** is still under development.  

More details on this toolkit can/will be found on my blog [L'endormitoire](http://www.endormitoire.wordpress.com).  