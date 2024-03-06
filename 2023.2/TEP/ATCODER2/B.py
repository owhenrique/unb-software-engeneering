def solve(B):
    if B == 1:
        return 1

    a, c = 1, B
    while a < c:
        d = a + (c - a) // 2
        rst = 1
        tmp = d
        while tmp > 0:
            if rst > B:
                break
            rst *= d
            tmp -= 1
        if rst == B:
            return d
        elif rst < B:
            a = d + 1
        else:
            c = d
    return -1

B = int(input())
rst = solve(B)
print(rst)