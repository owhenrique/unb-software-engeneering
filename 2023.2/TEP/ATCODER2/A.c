#include <stdio.h>
#include <stdlib.h>

#define max 105
char s[max];

int main()
{

    int n;

    scanf("%d", &n);

    getchar();

    for (int i = 0; i < n; i++)
    {
        scanf("%c", &s[i]);
    }

    // for (int i = 0; i < n; i++)
    // {
    //     for (int j = 1; j < n; j++)
    //     {
    //         if (s[i] == 'a' && s[j] == 'b' || s[i] == 'b' && s[j] == 'a')
    //         {
    //             printf("Yes\n");
    //             return 0;
    //         }
    //     }
    // }

    int i = 0;

    while (i < n)
    {
        if ((s[i] == 'a' && s[i + 1] == 'b') || (s[i] == 'b' && s[i + 1] == 'a'))
        {
            printf("Yes\n");
            return 0;
        }

        i++;
    }

    printf("No\n");

    return 0;
}