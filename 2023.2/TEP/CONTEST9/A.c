#include <stdio.h>

#define max 4

int A[max];
int B[max];

int solve(int vetor[])
{
    int sum = 0;
    for (int i = 0; i < 3; i++)
    {
        sum += vetor[i];
    }
    return sum;
}

int main()
{
    for (int i = 0; i < 3; i++)
        scanf(" %1d", &A[i]);

    for (int i = 0; i < 3; i++)
        scanf(" %1d", &B[i]);

    int somaA = solve(A);
    int somaB = solve(B);

    if (somaA > somaB)
        printf("%d\n", somaA);
    else if (somaB > somaA)
        printf("%d\n", somaB);
    else
        printf("%d\n", somaA);

    return 0;
}