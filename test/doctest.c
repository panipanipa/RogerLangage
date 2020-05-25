#include <stdio.h>

int affiche (int tab[], int taille) {
    int i ;
    for (i=0;i<taille;i++) {
        printf("%d", tab[i]) ;
    }
    printf("\n") ;
    return 0 ;
}



int main() {
    int taille = 10 ;
    int tab[10] = {9,8,7,6,5,4,3,2,1,0} ;
    affiche(tab , taille) ;
    int cond = 0 ;
    int boite ;
    int i ;
    while (cond<taille-1) {
        cond = 0 ;
        for (i=0;i<9;i++) {
            if (tab[i] > tab[i+1]) {
                boite = tab[i] ;
                tab[i] = tab[i+1];
                tab[i+1] = boite ;
            }
            else {
                cond++ ;
            }
        }
    }
    affiche (tab , taille) ;
    return 0 ;
}