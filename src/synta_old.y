%{
#include <stdio.h>
#include <stdlib.h>

%}
%union {
    int i ;
    char * str;
}

%token tColon tOpenBracket tCloseBracket tOpenParens tCloseParens tAdd tSub tMul tDiv tEq tSemiColon tTypeInt tPrintf tMain
tTypeVoid tConst
%token<i> tInteger
%token<str> tVariable

%left tOpenParens tCloseParens
%left tAdd tSub
%left tMul tDiv

%start MAIN 



%%

MAIN : TYPE tMain tOpenParens ARGUMENT tCloseParens tOpenBracket BODY tCloseBracket {printf("MAIN\n");};

TYPE : tTypeInt {printf("voilà un int\n");}
     | tTypeVoid {printf("voilà un void\n");};   

ARGUMENT : {printf("argument epsilon\n");}
         | DECLARATION_ARG {printf("arg\n");};

DECLARATION_ARG : TYPE VARIABLE_SET {printf("declaration arg simple\n");}
            | TYPE VARIABLE_SET tColon DECLARATION_ARG {printf("declaration arg multiple\n");};

VARIABLE_SET : tVariable {printf("var : %s ", $1);}
             | VARIABLE_SET tColon tVariable {printf(" %s ", $3);} ;

BODY : |
        INSTRUCTION {printf("BODY\n");}  ;

INSTRUCTION : INSTRUCTION DECLARATIONS {printf("INSTRUCTION\n");} 
    | INSTRUCTION AFFECTATION {printf("INSTRUCTION\n");}
    | INSTRUCTION IMPRIM
    | IMPRIM 
    | DECLARATIONS
    | AFFECTATION
    ;

IMPRIM : tPrintf tOpenParens tVariable tCloseParens tSemiColon {printf("IMPRIM %s \n", $3);} ;

DECLARATIONS : tTypeInt tVariable tSemiColon {printf("voila une declaration \n");}
             | tConst AFFECTATION  ;

AFFECTATION : tTypeInt VARIABLE_SET tEq  MATH tSemiColon {printf("voila une affectation \n");} 
            | VARIABLE_SET tEq MATH tSemiColon {printf("voila une affectation \n");} ;


 MATH : MATH tAdd MATH {printf(" + ");}
    | MATH tSub MATH  {printf(" - ");}
    | MATH tDiv MATH  {printf(" / ");}
    | MATH tMul MATH  {printf(" * ");}
    | tOpenParens MATH tCloseParens {printf(" () ");}
    | tVariable {printf("valeur =  %s \n", $1);}
    | tInteger {printf("valeur = %d \n", $1);} ;


// MATH : tInteger {printf("voila une affectation : valeur = %d \n", $1);} ;

%%

int yyerror(char * s){
    printf("%s\n", s);
}

int main(){
    yyparse();
}
