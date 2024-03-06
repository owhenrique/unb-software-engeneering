#include <stdio.h>

#define max 101
int s[max];

int main()
{

    int N, L, count = 0;

    scanf("%d %d", &N, &L);

    for (int i = 0; i < N; i++)
    {
        scanf("%d", &s[i]);
        if (s[i] >= L)
            count++;
    }

    printf("%d\n", count);

    return 0;
}