#include <stdio.h>

int solve(int matrix[9][9]) {
    int rows[9][10] = {0};
    int cols[9][10] = {0};
    int tmp[3][3][10] = {0};

    for (int i = 0; i < 9; i++) {
        for (int j = 0; j < 9; j++) {
            int num = matrix[i][j];

            if (rows[i][num] || cols[j][num] || tmp[i/3][j/3][num]) {
                return 0;
            }

            rows[i][num] = 1;
            cols[j][num] = 1;
            tmp[i/3][j/3][num] = 1;
        }
    }

    return 1;
}

int main() {
    int matrix[9][9];

    for (int i = 0; i < 9; i++) {
        for (int j = 0; j < 9; j++) {
            scanf("%d", &matrix[i][j]);
        }
    }

    if (solve(matrix)) {
        printf("Yes\n");
    } else {
        printf("No\n");
    }

    return 0;
}
