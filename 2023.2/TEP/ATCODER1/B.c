#include <stdio.h>
#include <stdlib.h>

int main()
{

    int N, c, d, u;

    scanf("%d", &N);

    u = N % 10;
    d = (N / 10) % 10;
    c = N / 100;


    if (c * d == u)
        printf("%d\n", N);

    else
    {
        while (N++)
        {
            u = N % 10;
            d = (N / 10) % 10;
            c = N / 100;

            if (c * d == u)
            {
                printf("%d\n", N);
                break;
            }
        }
    }
    return 0;
}