#include <stdio.h>
#include <stdlib.h>

int main(){

    int h, w;

    scanf("%d%d", &h, &w);

    char matrix[h][w];
    int elem;

    for(int i = 0; i < h; i++){
        for(int j = 0; j < w; j++)
            scanf("%c", &matrix[i][j]);
    }

    for(int i = 0; i < h; i++){
        for(int j = 0; j < w; j++){
            //printf("%d%c", A[(i*N) + j], (j == N - 1 ? '\n' : ' '));
            printf("%c ", matrix[i][j]); 

        }
        printf("\n");
    }
    
    return 0;
}