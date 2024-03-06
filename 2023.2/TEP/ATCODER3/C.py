N, Q = map(int, input().split())
S = input()

cumulative_count = [0] * (N + 1)
for i in range(1, N):
    cumulative_count[i + 1] = cumulative_count[i] + (S[i - 1] == S[i])

for _ in range(Q):
    l, r = map(int, input().split())
    result = cumulative_count[r] - cumulative_count[l]
    print(result)
