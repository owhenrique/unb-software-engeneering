#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main()
{
    char s[105];

    scanf("%s", s);

    int n = strlen(s);

    for (int i = 0; i < n; i++)
    {
        if (i % 2 == 0)
        {
            if (s[i] != 'R' && s[i] != 'D' && s[i] != 'U')
            {
                printf("No\n");
                return 0;
            }
        }
        else
        {
            if (s[i] != 'L' && s[i] != 'D' && s[i] != 'U')
            {
                printf("No\n");
                return 0;
            }
        }
    }

    printf("Yes\n");

    return 0;
}