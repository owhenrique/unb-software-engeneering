#include <stdio.h>

int main()
{

    int M, D, year, month, day;

    scanf("%d%d", &M, &D);
    scanf("%d %d %d", &year, &month, &day);

    if (day + 1 <= D)
        printf("%d %d %d", year, month, day + 1);
    else
    {
        if (month + 1 <= M)
            printf("%d %d 1", year, month + 1);
        else
        {
            printf("%d 1 1", year + 1);
        }
    }

    printf("\n");
    
    return 0;
}