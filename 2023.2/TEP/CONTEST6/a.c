#include <stdio.h>
#include <stdlib.h>

int main()
{
    int n, a, b;

    scanf("%d%d%d", &n, &a, &b);

    printf("%d\n", (n - a) + b);

    return 0;
}