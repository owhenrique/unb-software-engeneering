#include <stdio.h>
#include <stdlib.h>

int main()
{
    int X, Y;

    scanf("%d %d", &X, &Y);

    if (X < Y && Y - X > 2)
        printf("No\n");
    else if (X < Y && Y - X <= 2)
        printf("Yes\n");
    else if (X > Y && X - Y > 3)
        printf("No\n");
    else if (X > Y && X - Y <= 3)
        printf("Yes\n");

    return 0;
}