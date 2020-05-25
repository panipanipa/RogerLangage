%{
#include <stdio.h>
#include <stdlib.h>
#include "table_symbole.h"
#include "pile_tmp.h"
#include "pile_asm.h"
%}

%union {
    int i ;
    char * str;
}

%token tColon tOpenBracket tCloseBracket tOpenParens tCloseParens tAdd tSub tMul 
tDiv tEq tSemiColon tTypeInt tPrintf tMain tTypeVoid tConst tIf tWhile
%token<i> tInteger
%token<str> tVariable


%left tAdd tSub
%left tMul tDiv
%left tOpenParens tCloseParens

%type<i> MATH
%type<str> VARIABLE_SET
%start MAIN 



%%

MAIN : TYPE tMain tOpenParens ARGUMENT tCloseParens tOpenBracket BODY tCloseBracket {};

TYPE : tTypeInt {}
     | tTypeVoid {};   

ARGUMENT : {}
         | DECLARATION_ARG {};

DECLARATION_ARG : TYPE VARIABLE_SET {printf("declaration arg simple\n");}
            | TYPE VARIABLE_SET tColon DECLARATION_ARG {printf("declaration arg multiple\n");};

VARIABLE_SET : tVariable {Padd($1) ;}
             | VARIABLE_SET tColon tVariable {Padd($3) ;} ;

BODY : |
        INSTRUCTION {printf("BODY\n");}  ;

IF : tIf tOpenParens 
    MATH 
    tCloseParens tOpenBracket { } 
    BODY 
    tCloseBracket {
                    printf("IF\n");
                };

WHILE : tWhile tOpenParens MATH tCloseParens tOpenBracket BODY tCloseBracket {printf("WHILE\n");};


INSTRUCTION : INSTRUCTION DECLARATIONS {printf("INSTRUCTION\n");} 
    | INSTRUCTION AFFECTATION {printf("INSTRUCTION\n");}
    | INSTRUCTION IMPRIM
    | INSTRUCTION IF
    | INSTRUCTION WHILE
    | WHILE
    | IF
    | IMPRIM 
    | DECLARATIONS
    | AFFECTATION
    ;

IMPRIM : tPrintf tOpenParens tVariable tCloseParens tSemiColon {printf("IMPRIM %s \n", $3);} ;

DECLARATIONS : tTypeInt tVariable tSemiColon { int address = start_var + 16*next ;
                                                insert($2, false, false, address) ; 
                                                //printf("voila une declaration \n") ;
                                            }
             | tConst AFFECTATION  ;

AFFECTATION : tTypeInt VARIABLE_SET tEq  MATH tSemiColon {
                                                        int tmp = P_tmp_remove() ;
                                                        printf("LOAD r0 %x \n", tmp) ; 
                                                        while(pileVar!=NULL) {
                                                                char * id =  Premove() ;
                                                                //printf("%s\n", id) ;
                                                                int index = exist(id) ;
                                                                int address = start_var + (16*next) ;
                                                                if(index==-1)
                                                                    insert(id, false, true, address) ;   
                                                                printf("aff STORE %x r0 \n", table[next-1].address) ;
                                                            }  
                                                            print_table() ;
                                                        //printf("voila une affectation \n");
                                                         } 
            | VARIABLE_SET tEq MATH tSemiColon {int tmp = P_tmp_remove() ;
                                                int index = exist($1) ; 
                                                table[index].init = true ;
                                                printf("LOAD r0 %x \n", tmp) ; 
                                                printf("var STORE %x r0 \n", table[index].address);
                                                } ;


 MATH : MATH tAdd MATH {int a = P_tmp_remove() ; 
                        int b = P_tmp_remove() ;
                        printf("ADD %x %x %x\n", sommet, a, b) ;
                        sommet += sizeof(int) ;
                        }
    | MATH tSub MATH  {int a = P_tmp_remove() ; 
                        int b = P_tmp_remove() ;
                        printf("SOU %x %x %x\n", sommet, a, b) ;
                        sommet += sizeof(int) ;
                        }
    | MATH tDiv MATH  {int a = P_tmp_remove() ; 
                        int b = P_tmp_remove() ;
                        printf("DIV %x %x %x\n", sommet, a, b) ;
                        sommet += sizeof(int) ;
                        }
    | MATH tMul MATH  {int a = P_tmp_remove() ; 
                        int b = P_tmp_remove() ;
                        printf("MUL %x %x %x\n", sommet, a, b) ;
                        sommet += sizeof(int) ;
                        }
    | tOpenParens MATH tCloseParens {printf(" () ");}
    | tVariable {int index = exist($1) ; if(index!=-1) P_tmp_add2(table[index].address) ;}
    | tInteger { P_tmp_add($1); } ;


%%

int yyerror(char * s){
    printf("%s\n", s);
}

int main(){
    yyparse();
}
