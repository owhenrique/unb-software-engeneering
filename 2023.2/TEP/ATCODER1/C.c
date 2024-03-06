#include <stdio.h>
#include <stdlib.h>

#define MAX 300005
int s[MAX];

int main()
{

    int n, m;

    scanf("%d %d", &n, &m);

    for (int i = 0; i < n; i++)
    {
        scanf("%d", &s[i]);
    }

    float x = s[0] / 2;
    printf("%f\n", x);

    int tmp = 0, i = 0;

    while (s[i] >= x && s[i] < x + m)
    {
        i++;
        tmp++;
    }

    printf("%d\n", tmp);

    return 0;
}