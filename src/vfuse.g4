grammar VFuse;

OPEN_BRACKET : '<';
CLOSE_BRACKET : '>';
SLASH : '/';
EQUALS : '=';
STRING : '"' ~["<"]* '"';
IDENTIFIER : [a-zA-Z]+;

program : element*;

element : OPEN_BRACKET IDENTIFIER attribute* CLOSE_BRACKET element* CLOSE_BRACKET
        | OPEN_BRACKET SLASH IDENTIFIER CLOSE_BRACKET;

attribute : IDENTIFIER EQUALS STRING;