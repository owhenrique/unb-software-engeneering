#include <stdio.h>
#include <stdlib.h>

int main(){

    int n, k;
    long long int x, y, maior = 0;
    
    scanf("%d%d", &n, &k);

    long long int *v = malloc(n * sizeof(long long int));

    for(int i = 0; i < n; i++)
        scanf("%lld", &v[i]);

    for(int i = 0; i <= k; i++){
        y = 0;

        for(int j = 0; j < n; j++)
            y += (~v[j] & i) | (v[j] & ~i);

        if(y > maior)
            maior = y;
    }

    printf("%lld", maior);
    free(v);
    return 0;
}