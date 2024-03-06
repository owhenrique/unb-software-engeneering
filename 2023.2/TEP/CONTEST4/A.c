#include <stdio.h>
#include <stdio.h>
#include <string.h>

#define max 7
char s[max];

int main()
{

    int i = 0;

    while (scanf("%c", &s[i]) != '\n' && i < sizeof(s) - 1)
    {
        if (s[i] == '\n')
            break;
        i++;
    }

    s[i] = '\0';

    if (strcmp(s, "Sunny") == 0)
        printf("Cloudy\n");

    else if (strcmp(s, "Cloudy") == 0)
        printf("Rainy\n");

    else if (strcmp(s, "Rainy") == 0)
        printf("Sunny\n");

    return 0;
}