#include <stdio.h>
#include <stdlib.h>

int main(void){

    int N, good = 0, poor = 0;
    
    scanf("%d", &N);

    char *S = malloc(N * sizeof(char));

    scanf("%s", S);

    for(int i = 0; i < N; i++){

        if(S[i] == 'o'){
            good++;
        }

        if(S[i] == 'x'){
            poor++;
        }
    }


    if(good > 0 && poor == 0){
        printf("Yes\n");
    }

    else{
        printf("No\n");
    }

    free(S);

    return 0;
}