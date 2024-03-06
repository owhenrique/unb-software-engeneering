#include <stdio.h>

int main() {
    int N;
    scanf("%d", &N);

    int A[N];
    for (int i = 0; i < N; i++) {
        scanf("%d", &A[i]);
    }

    for (int i = 0; i < N; i++) {
        int sum = 0;
        for (int j = 0; j < N; j++) {
            if (j != i && A[j] > A[i]) {
                sum += A[j];
            }
        }
        printf("%d", sum);
        printf(i == N - 1 ? "\n" : " ");
    }

    return 0;
}
