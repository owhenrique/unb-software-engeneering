#include <stdio.h>
#include <stdlib.h>

int main(){

    int n, a, b, x;

    scanf("%d", &n);
    scanf("%d%d", &a, &b); 

    for(int i = 1; i <= n; i++){
        scanf("%d", &x);

        if(a+b == x)
            printf("%d\n", i);
    }

    return 0;
}