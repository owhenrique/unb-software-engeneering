#include <stdio.h>
#include <stdio.h>
#include <math.h>

int main(){

    int a, b, c, d;

    scanf("%d%d%d%d", &a, &b, &c, &d);

    if(a-c > 0){
        if(a-c > d){
            if(a-b > d || b-c > d)
                printf("No");
            else
                printf("Yes");
        }
        else
            printf("Yes");
    }

    else{
        if(c-a > d){
            if(b-a > d || c-b > d)
                printf("No");
            else
                printf("Yes");
        }
        else
            printf("Yes");
    }

    return 0;

}