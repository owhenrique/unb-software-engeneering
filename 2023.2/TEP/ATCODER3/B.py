def solve(N, s):
    sum = 0

    for i in range(1, N + 1):
        for j in range(1, s[i - 1] + 1):
            if all(digit == str(j % 10) for digit in str(i) + str(j)):
                sum += 1

    return sum


N = int(input())
s = list(map(int, input().split()))


result = solve(N, s)
print(result)
