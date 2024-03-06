#include <stdio.h>

#define max 105
int m[105][105];

int main() {
    int n, w;

    scanf("%d%d", &n, &w);

    int less = 101, sum = 0;

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < w; j++) {
            scanf("%d", &m[i][j]);

            if (m[i][j] < less)
                less = m[i][j];

            sum += m[i][j];
        }
    }

    int count = sum - (less * n * w);

    printf("%d\n", count);

    return 0;
}