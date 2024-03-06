#include <stdio.h>

int solveD(int n)
{
    while (n > 0)
    {
        int digit = n % 10;
        if (digit == 7)
        {
            return 1;
        }
        n /= 10;
    }
    return 0;
}

int solveO(int number)
{
    while (number > 0)
    {
        int digit = number % 8;
        if (digit == 7)
        {
            return 1;
        }
        number /= 8;
    }
    return 0;
}

int main()
{

    int n, count = 0;

    scanf("%d", &n);

    for (int i = 1; i <= n; i++)
    {
        if (solveD(i) == 0 && solveO(i) == 0)
            count++;
    }

    printf("%d\n", count);

    return 0;
}