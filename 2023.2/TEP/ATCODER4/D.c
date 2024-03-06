#include <stdio.h>

#define MAX 2010

char m[MAX][MAX];

int solve(char m[MAX][MAX], int N) {
    int count = 0;

    int row_count[MAX] = {0};
    int col_count[MAX] = {0};

    // Contagem de "o" por linha e coluna
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            if (m[i][j] == 'o') {
                row_count[i]++;
                col_count[j]++;
            }
        }
    }

    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            if (m[i][j] == 'o') {
                count += (row_count[i] - 1) * (col_count[j] - 1);
            }
        }
    }

    return count;
}

int main() {
    int N;

    scanf("%d", &N);
    for (int i = 0; i < N; i++) {
        scanf("%s", m[i]);
    }

    printf("%d\n", solve(m, N));

    return 0;
}
