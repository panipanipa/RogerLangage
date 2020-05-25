#include <stdio.h>
#include "table_symbole.h"


#define GRAND 50

struct maStruct table[GRAND] ;
//add r0 = 0
//add r8 = 8 etc..
const int start_var = 0x0100 ; //A DEFINIR
int next = 0 ;
int current_depth = 0 ;
struct cell * pileVar = NULL ;

void Padd(char * id) {
    struct cell * mycell = malloc(sizeof(struct cell)) ;
    mycell->id = id ;
    mycell->next = pileVar ;
    pileVar = mycell ;
}

char * Premove() {
    char * id = pileVar->id ;
    struct cell * aux = pileVar ;
    pileVar = pileVar->next ;
    free(aux) ;
    return id ;
}

void Toempty(bool constant, bool init) {
   // printf("toempty : \n") ;
    while(pileVar!=NULL) {
        char * id =  Premove() ;
        int address = start_var+(16*next) ;
        insert(id,  constant, init, address) ;     
    }    
}

void peek() {
    printf("<peek ") ;
    if (next>0) {
        int i = next-1 ;
        printf("nom : %s ", table[i].id) ;
        printf("address : %x ", table[i].address) ;
        if(table[i].init) {
            printf("init : true ") ;
        }
            
    }
    printf(" peek> ") ;
}

void print_table() {
    printf("<table \n") ;
    for(int i=0; i<next;i++) {
        printf("nom : %s ", table[i].id) ;
        printf("depth : %d ", table[i].depth) ;
        printf("address : %x ", table[i].address) ;
        if(table[i].init) {
            printf("init : true ") ;
        }
        printf("\n") ;
    }
    printf("table> \n") ;
}

void remove_table() {
    if(next>0)
        next-- ;
}

int exist(char* nom) {
    int index = 0 ;
    bool trouve = false ;
    while(!trouve && index<next) {
        if (strcmp(table[index].id,nom)==0) {
            trouve = true ;
        }
        else {
             index++ ;
        }
    }
    if (!trouve) {
        index = -1 ;
    }    
    return index ;
}

//TODO : rajouter la porter dans le insert 
void insert(char* id, bool constant, bool init, int address) {
    struct maStruct noeud ;
    noeud.id = id;
    noeud.constant = constant ;
    noeud.init = init ;
    noeud.address = address ;
    noeud.depth = current_depth ;
    table[next] = noeud ;
    next++;
}

/*
void modify(char* id) {
    int var = exist(id) ;
    if(var !=-1) {
        table[var].init = true ;
    }
    else {
        printf("ERROR : %s NOT EXIST", id) ;
    }
} 
*/
