#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int main(){

    int a, b, c, delta;
    double x1, x2;

    scanf("%d%d%d", &a, &b, &c);

    if(a == 0)
        printf("-1\n");

    else{
        delta = (b*b) - (4*a*c);
        
        if(delta < 0)
            printf("0\n");

        else{
            x1 = (-b + sqrt(delta))/2*a;
            x2 = (-b - sqrt(delta))/2*a;

            if(x1 == x2){
                printf("1\n");
                printf("%.10lf\n", x1);
            }
            
            else{
                printf("2\n");
                if(x1 < x2)
                    printf("%.10lf\n%.5lf\n", x1, x2);
                else
                    printf("%.10lf\n%.5lf\n", x2, x1);
            }
        }
    }

    return 0;
}