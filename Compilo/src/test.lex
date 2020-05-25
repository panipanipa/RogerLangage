/* Définitions */
%{
#include "y.tab.h"

%}

digit [0-9]
integer -?{digit}+
exponent [eE][+-]?{integer}
integer_exponent {digit}\.{integer}{exponent}
var_name [a-zA-Z][_a-zA-Z0-9]*

/*Règles*/
%%
[ \n\t]+ {}
, {return tColon ;}
\{ {return tOpenBracket ;}
\} {return tCloseBracket ;}
\( {return tOpenParens ;}
\) {return tCloseParens ;}
\+ {return tAdd ;}
\- {return tSub ;}
\* {return tMul ;}
\/ {return tDiv ;}
\= {return tEq ;}
\; {return tSemiColon ;}
const {return tConst ;}
int {return tTypeInt ;}
if {return tIf ;}
while {return tWhile ;}
printf {return tPrintf ;}
{integer} {yylval.i = atoi(yytext) ; return tInteger ;}
{integer_exponent} {yylval.i = atof(yytext) ; return tInteger ;}
main {return tMain ;}
void {return tTypeVoid ;}
{var_name} {yylval.str=strdup(yytext) ; return tVariable ;}

%%

int yywrap(){
    return 1;
}


