#include <stdio.h>

int minimum_cost(int N, int S, int M, int L) {
    int min_cost = __INT_MAX__;

    for (int i = 0; i <= N / 6; i++) {
        for (int j = 0; j <= N / 8; j++) {
            int k = (N - i * 6 - j * 8 + 11) / 12;
            int total_eggs = i * 6 + j * 8 + k * 12;

            if (total_eggs >= N) {
                int cost = i * S + j * M + k * L;
                min_cost = cost < min_cost ? cost : min_cost;
            }
        }
    }

    return min_cost;
}

int main() {
    int N, S, M, L;
    scanf("%d %d %d %d", &N, &S, &M, &L);

    int result = minimum_cost(N, S, M, L);
    printf("%d\n", result);

  return 0;
}