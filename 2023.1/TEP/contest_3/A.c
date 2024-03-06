#include <stdio.h>
#include <stdlib.h>

int main(){

    int a, b, c;
    int x = -1;

    scanf("%d%d%d", &a, &b, &c);

    for(int i = a; i <= b; i++){
        if(i%c == 0){
            printf("%d\n", i);
            x = i;
            break;
        }
    }

    if(x == -1)
        printf("-1\n");

    return 0;
}