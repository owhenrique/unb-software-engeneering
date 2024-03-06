N = int(input())
A = list(map(int, input().split()))

max_val = A[-1]
sum_val = 0

result = []

for i in range(N - 1, -1, -1):
    if A[i] > max_val:
        max_val = A[i]
    else:
        sum_val += max_val

    result.insert(0, str(sum_val))

print(" ".join(result))