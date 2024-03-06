from math import factorial

def solve(perm):
    rank = 0
    n = len(perm)
    for i in range(n):
        count = 0
        for j in range(i + 1, n):
            if perm[j] < perm[i]:
                count += 1
        rank += count * factorial(n - i - 1)
    return rank

def permutate(n, p, q):
    a = solve(p)
    b = solve(q)
    return abs(a - b)

n = int(input())
p = list(map(int, input().split()))
q = list(map(int, input().split()))

result = permutate(n, p, q)
print(result)