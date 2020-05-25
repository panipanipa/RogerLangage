#include <stdio.h>
#include "pile_tmp.h"
#include "tab_asm.h"

struct cell2 * pileTmp = NULL ;

int base_pile = 0x3000 ; //adresse a definir
int sommet = 0x3000 ;

void P_tmp_add(int id) {
    //printf("add pile\n") ;
    sommet+=sizeof(int) ;
    //printf("AFC %x %d\n", sommet, id) ;
    insertA("AFC", sommet, id, -1) ;
}

void P_tmp_add2(int address) {
    sommet+=sizeof(int) ;
    insertA("LOAD", 0, address, -1) ;
    insertA("AFC", sommet, 0, -1) ;
    //printf("LOAD r0 %x\n", address);
    //printf("AFC %x r0\n", sommet) ;
}

int P_tmp_remove() {
    //printf("remove pile\n") ;
    if(sommet==base_pile) {
        printf("error\n") ;
        return -1 ;
    }
    else {
        sommet -= sizeof(int) ;
        return sommet ;
    }
}
