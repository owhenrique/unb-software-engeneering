#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(){

    int k;
    int a, b;
    int x = 0, y = 0;

    int digit, decimal = 0, multiplier = 1;

    scanf("%d", &k);
    scanf("%s%s", a, b);

    int len_a = strlen(a);
    int len_b = strlen(b);

    for(int i = len_a - 1; i >= 0; i--){
        digit = a[i] - '0';
        x += digit * multiplier;
        multiplier *= k;
    }

    decimal = 0; 
    multiplier = 1;

    for(int i = len_b - 1; i >= 0; i--){
        digit = b[i] - '0';
        y += digit * multiplier;
        multiplier *= k;
    }

    printf("%d\n", x*y);

    return 0;
}