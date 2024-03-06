def count_triples(N, grid):
    count = 0

    # Verifica todas as combinações possíveis de triples de células
    for i in range(N):
        for j in range(N):
            if grid[i][j] == 'o':
                # Verifica todas as células na mesma linha
                for k in range(N):
                    if k != j and grid[i][k] == 'o':
                        # Verifica todas as células na mesma coluna
                        for l in range(N):
                            if l != i and grid[l][j] == 'o':
                                count += 1

    return count // 2  # Divide por 2 para evitar a contagem duplicada

# Leitura de entrada
N = int(input())
grid = [input() for _ in range(N)]

# Chamada da função e impressão do resultado
result = count_triples(N, grid)
print(result)