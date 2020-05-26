%{
#include <stdio.h>
#include <stdlib.h>
#include "table_symbole.h"
#include "pile_tmp.h"
#include "tab_asm.h"
%}

%union {
    int i ;
    char * str;
}

%token tColon tOpenBracket tCloseBracket tOpenParens tCloseParens tAdd tSub tMul 
tDiv tEq tSemiColon tTypeInt tPrintf tMain tTypeVoid tConst
%token<i> tInteger
%token<str> tVariable
%token<i> tIf
%token<i> tElse
%token<i> tWhile


%left tAdd tSub
%left tMul tDiv
%left tOpenParens tCloseParens

%type<i> MATH
%type<i> IF
%type<str> VARIABLE_SET
%start MAIN 



%%

MAIN : TYPE tMain tOpenParens ARGUMENT tCloseParens tOpenBracket BODY tCloseBracket {ToemptyA();};

TYPE : tTypeInt {}
     | tTypeVoid {};   

ARGUMENT : {}
         | DECLARATION_ARG {};

DECLARATION_ARG : TYPE VARIABLE_SET {}
            | TYPE VARIABLE_SET tColon DECLARATION_ARG {};

VARIABLE_SET : tVariable {Padd($1) ;}
             | VARIABLE_SET tColon tVariable {Padd($3) ;} ;

BODY : |
        INSTRUCTION {}  ;

IF : tIf tOpenParens 
    MATH {insertA("CMP", $3, 0, -1); insertA("JMPF", -2, -1, -1); $1 = nextA-1 ;}
    tCloseParens tOpenBracket {current_depth++;} 
    BODY 
    tCloseBracket {
                    current_depth--;
                    tableA[$1].adA = nextA+2 ;
                    insertA("NOP", -1, -1, -1) ;
                    printf("IF\n");
                };

ELSE : IF tElse  tOpenBracket {nextA = nextA-1 ; insertA("JMP", -2, -1, -1); $1 = nextA-1 ; current_depth++;} 
        BODY 
        tCloseBracket {
                        current_depth--;
                        tableA[$1].adA = nextA + 1;
                        printf("ELSE\n");
                    } ;

WHILE : tWhile tOpenParens MATH {insertA("CMP", $3, 0, -1); insertA("JMPF", -2, -1, -1);  $1 = nextA-1 ;}
        tCloseParens tOpenBracket {current_depth++;} 
        BODY {insertA("JMP", $1, -1, -1);}
        tCloseBracket {current_depth--; tableA[$1].adA = nextA+1 ;} ;


INSTRUCTION : INSTRUCTION DECLARATIONS {} 
    | INSTRUCTION AFFECTATION {}
    | INSTRUCTION IMPRIM
    | INSTRUCTION IF
    | INSTRUCTION WHILE
    | INSTRUCTION ELSE
    | WHILE
    | IF
    | ELSE
    | IMPRIM 
    | DECLARATIONS
    | AFFECTATION
    ;

IMPRIM : tPrintf tOpenParens tVariable tCloseParens tSemiColon {printf("IMPRIM %s \n", $3);} ;

DECLARATIONS : tTypeInt tVariable tSemiColon { int address = start_var + 16*next ;
                                                insert($2, false, false, address) ; 
                                            }
             | tConst AFFECTATION  ;

AFFECTATION : tTypeInt VARIABLE_SET tEq  MATH tSemiColon {
                                                        int tmp = P_tmp_remove() ; 
                                                        insertA("LOAD", 0, tmp, -1) ;
                                                        while(pileVar!=NULL) {
                                                                char * id =  Premove() ;
                                                                int index = exist(id) ;
                                                                int address = start_var + (16*next) ;
                                                                if(index==-1)
                                                                    insert(id, false, true, address) ;
                                                                insertA("STORE", table[next-1].address, 0, -1) ;  
                                                            }  
                                                            //print_table() ;
                                                         } 
            | VARIABLE_SET tEq MATH tSemiColon {int tmp = P_tmp_remove() ;
                                                int index = exist($1) ; 
                                                table[index].init = true ;
                                                insertA("LOAD", 0, tmp, -1) ; 
                                                insertA("STORE",table[index].address, 0, -1);
                                                } ;


 MATH : MATH tAdd MATH {int a = P_tmp_remove() ; 
                        int b = P_tmp_remove() ;
                        insertA("ADD", sommet, a , b) ;
                        sommet += sizeof(int) ;
                        }
    | MATH tSub MATH  {int a = P_tmp_remove() ; 
                        int b = P_tmp_remove() ;
                        insertA("SOU", sommet, a , b) ;
                        sommet += sizeof(int) ;
                        }
    | MATH tDiv MATH  {int a = P_tmp_remove() ; 
                        int b = P_tmp_remove() ;
                        insertA("DIV", sommet, a , b) ;
                        sommet += sizeof(int) ;
                        }
    | MATH tMul MATH  {int a = P_tmp_remove() ; 
                        int b = P_tmp_remove() ;
                        insertA("MUL", sommet, a , b) ;
                        sommet += sizeof(int) ;
                        }
    | tOpenParens MATH tCloseParens {}
    | tVariable {int index = exist($1) ; if(index!=-1) P_tmp_add2(table[index].address) ;}
    | tInteger { P_tmp_add($1); } ;


%%

int yyerror(char * s){
    printf("%s\n", s);
}

int main(){
    yyparse();
}
