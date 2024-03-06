#include <stdio.h>
#include <math.h>

int main() {
    long long D;
    scanf("%lld", &D);

    long long x, y, min;
    min = D;

    for (x = 0; x * x <= D && x <= (long long)sqrt(D); x++) {
        y = (long long)sqrt(D - x * x);

        min = fmin(min, llabs(x * x + y * y - D));
    }

    printf("%lld\n", min);

    return 0;
}