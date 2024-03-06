#include <stdio.h>
#include <stdlib.h>

int main(){

    long long int l, r, x, y, maior = 0;

    scanf("%lld%lld", &l, &r);
    
    x = l;
    
    for(int i = l+1; i <= r; i++){

        y = (~x & i) | (x & ~i);

        if(y > maior)
            maior = y;

        x++;
    }

    printf("%lld\n", maior);

    return 0;
}