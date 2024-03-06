#include <stdio.h>
#include <stdlib.h>

int main() {
    int N, M;
    scanf("%d %d", &N, &M);

    int A[M], B[M];
    int *X = (int *)calloc(N + 1, sizeof(int));

    for (int i = 0; i < M; i++) {
        scanf("%d", &A[i]);
    }

    for (int i = 0; i < M; i++) {
        scanf("%d", &B[i]);
    }

    for (int i = 0; i < M; i++) {
        if (X[A[i]] == 0 && X[B[i]] == 0) {
            X[A[i]] = 1;
            X[B[i]] = 2;
        } else if (X[A[i]] == 0 || X[B[i]] == 0) {
            continue;
        } else if (X[A[i]] != 1 || X[B[i]] != 2) {
            printf("No\n");
            free(X);
            return 0;
        }
    }

    printf("Yes\n");
    free(X);
    return 0;
}
