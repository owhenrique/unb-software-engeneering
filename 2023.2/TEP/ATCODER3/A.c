#include <stdio.h>

#define max 9
int s[max];

int main()
{

    int N, X, sum = 0;

    scanf("%d%d", &N, &X);

    for (int i = 0; i < N; i++)
    {
        scanf("%d", &s[i]);
        if (s[i] <= X)
        {
            sum += s[i];
        }
    }

    printf("%d\n", sum);
    return 0;
}