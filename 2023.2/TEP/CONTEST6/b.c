#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define max 100005
long long int s[max];

int main()
{
    long long int n, x, md = 0, cd = 0;
    double ed = 0;

    scanf("%lld", &n);

    for (int i = 0; i < n; i++)
    {
        scanf("%lld", &s[i]);

        if (abs(s[i]) > cd)
            cd = abs(s[i]);

        md += abs(s[i]);

        ed += pow(s[i], 2);
    }

    printf("%lld\n%.15lf\n%lld\n", md, sqrt(ed), cd);

    return 0;
}