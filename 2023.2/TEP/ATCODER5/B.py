def minimum_cost(N, S, M, L):
    min_cost = float('inf')

    for i in range(N//6 + 1):
        for j in range(N//8 + 1):
            k = max(0, (N - i * 6 - j * 8 + 11) // 12)
            total_eggs = i * 6 + j * 8 + k * 12

            if total_eggs >= N:
                cost = i * S + j * M + k * L
                min_cost = min(min_cost, cost)

    return min_cost

# Leitura da entrada
N, S, M, L = map(int, input().split())

result = minimum_cost(N, S, M, L)
print(result)
