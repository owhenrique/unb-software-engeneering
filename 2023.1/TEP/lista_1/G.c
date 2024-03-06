#include <stdio.h>
#include <stdlib.h>

int main(){
    int v[5];
    int repetidos = 0;

    for(int i = 0; i < 4; i++)
        scanf("%d", &v[i]);

    for(int i = 0; i < 4; i++){
        if(i == 3)
            break;

        else{
            if(v[i] == v[i+1])
                repetidos++;
        }
    }

    printf("%d\n", repetidos);

}