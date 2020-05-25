#include <stdio.h>
#include <stdlib.h>
#define GRANDA 50

struct asmLine {
    char* asmIns ;
    int adA ;
    int adB ;
    int adC ;
};

extern struct asmLine tableA[GRANDA] ;
int nextA ;

//tab
void insertA(char * ins, int ad1, int ad2, int ad3) ;
void ToemptyA() ;

