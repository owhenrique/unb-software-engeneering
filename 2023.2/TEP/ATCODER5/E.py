def solve(N, M, L, a, b, prohibited):
    # Encontrar o preço mínimo para pratos laterais que estão em uma combinação proibida
    invalid_b_prices = set(b[j - 1] for i, j in prohibited)
    min_invalid_b = min(invalid_b_prices) if invalid_b_prices else float('inf')

    # Encontrar o preço máximo para pratos principais
    max_a = max(a)

    # Calcular o preço máximo total
    max_price = max(max_a, min_invalid_b + max(b))

    return max_price

# Leitura da entrada
N, M, L = map(int, input().split())
a = list(map(int, input().split()))
b = list(map(int, input().split()))

prohibited = [tuple(map(int, input().split())) for _ in range(L)]

# Chamada da função e impressão do resultado
result = solve(N, M, L, a, b, prohibited)
print(result)
