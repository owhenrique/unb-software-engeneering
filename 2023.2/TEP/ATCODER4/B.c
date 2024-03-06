#include <stdio.h>
#include <stdlib.h>

#define max 200001
int A[max];

int main()
{
    int N, L, R;
    scanf("%d %d %d", &N, &L, &R);

    for (int i = 0; i < N; i++)
    {
        scanf("%d", &A[i]);
    }

    for (int i = 0; i < N; i++)
    {
        if (A[i] >= L && A[i] <= R)
        {
            printf("%d ", A[i]);
        }
        else
        {
            if (abs(A[i] - L) <= abs(A[i] - R))
            {
                printf("%d ", L);
            }
            else
            {
                printf("%d ", R);
            }
        }
    }

    printf("\n");

    return 0;
}
