#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h> 
#include "string.h"
#define GRAND 50

struct maStruct {
    char* id ; //nom
    bool constant;
    bool init ;
    int address ; //emplacement mémoire
    int depth ; //portée de la variable
};

struct cell {
    char * id ;
    struct cell * next ;
};

extern struct maStruct table[GRAND] ;
const int start_var ; //A DEFINIR
extern int next ;
extern int current_depth ;
struct cell * pileVar ;

//PILE
void Padd(char * id) ;
char* Premove() ;
void Toempty( bool constant, bool init) ;

//TABLE
void peek() ;
void print_table() ;
int exist(char* nom) ;
void insert(char* id, bool constant, bool init, int address) ;
void remove_table() ;
//void modify(char* id, int value) ;