#include <stdio.h>

int main() {
    int k, a, b;
    int digit, multiplier = 1;

    int decimal_a = 0, decimal_b = 0;

    scanf("%d%d%d", &k, &a, &b);

    while (a > 0) {
        digit = a % 10;
        decimal_a += digit * multiplier;
        multiplier *= k;
        a = a / 10;
    }

    multiplier = 1;

    while (b > 0) {
        digit = b % 10;
        decimal_b += digit * multiplier;
        multiplier *= k;
        b = b / 10;
    }

    printf("%d", decimal_a*decimal_b);

    return 0;
}
