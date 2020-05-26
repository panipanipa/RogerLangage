#include <stdio.h>
#include "tab_asm.h"
#include "string.h"

#define GRANDA 50

struct asmLine tableA[GRANDA] ;
struct cell_asm * pileASM = NULL ;
int nextA = 0 ;

void insertA(char * ins, int ad1, int ad2, int ad3) {
    struct asmLine myasm ;
    myasm.asmIns = ins ;
    myasm.adA = ad1 ;
    myasm.adB = ad2 ;
    myasm.adC = ad3 ;
    tableA[nextA] = myasm ;
    nextA++ ;
}

void ToemptyA() {
    int i = 0 ;
    FILE * myfile = fopen("./code", "w+") ;
    for(i=0 ; i<nextA ; i++) {
        struct asmLine myasm =  tableA[i] ;
         if(myasm.adC==-1)
            if(strcmp(myasm.asmIns, "JMPF")==0 || strcmp(myasm.asmIns, "JMP")==0 )
                fprintf(myfile, "%s %d \n", myasm.asmIns,myasm.adA) ;
            else
            fprintf(myfile, "%s %x %x \n", myasm.asmIns,myasm.adA, myasm.adB) ;
        else
            fprintf(myfile, "%s %x %x %x\n", myasm.asmIns, myasm.adA, myasm.adB, myasm.adC) ;
    }
    fclose(myfile) ;
    nextA = 0 ;
}

