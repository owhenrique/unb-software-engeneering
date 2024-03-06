#include <stdio.h>
#include <stdlib.h>

int main()
{   
    int N;

    scanf("%d", &N);

    int *A = malloc(N * N * sizeof(int));
    int *B = malloc(N * N * sizeof(int));
    int *A_temp = malloc(N * N * sizeof(int));


    for(int i = 0; i < N; i++){
        for(int j = 0; j < N; j++){
            scanf("%d", &A[(i*N) + j]); 
        }
    }

    /*for(int i = 0; i < N; i++){
        for(int j = 0; j < N; j++){
            scanf("%d", &B[(i*N) + j]); 
        }
    }*/

    for(int i = 0; i < N; i++){
        for(int j = 0; j < N; j++){
            A_temp[(j*N) + i] = A[(i*N) + j]; 
        }
    }

    printf("\n");

    for(int i = 0; i < N; i++){
        for(int j = 0; j < N; j++){
            //printf("%d%c", A[(i*N) + j], (j == N - 1 ? '\n' : ' '));
            printf("%d%c", A_temp[(i*N) + j], (j == N - 1 ? '\n' : ' ')); 

        }
    }
    
    return 0;
}