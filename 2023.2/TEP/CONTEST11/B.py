def solve(S):
    count = 0
    n = len(S)

    for i in range(n - 2):
        if S[i] == 'A' and S[i + 1] == 'B' and S[i + 2] == 'C':
            count += 1

    return count

n = int(input())
s = input()

print(solve(s))
