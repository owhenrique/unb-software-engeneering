#include <stdio.h>

int solve(int N, int s[]) {
    int sum = 0;

    for (int i = 1; i <= N; ++i) {
        for (int j = 1; j <= s[i - 1]; ++j) {
            int isRepdigit = 1;
            int temp = j;
            while (temp > 0) {
                int digit = temp % 10;
                if (digit != i && digit != j % 10) {
                    isRepdigit = 0;
                    break;
                }
                temp /= 10;
            }
            if (isRepdigit) {
                sum += 1;
            }
        }
    }

    return sum;
}

int main() {
    int N;
    scanf("%d", &N);

    int s[N];
    for (int i = 0; i < N; ++i) {
        scanf("%d", &s[i]);
    }

    int result = solve(N, s);
    printf("%d\n", result);

    return 0;
}
