import math

a, b, c = map(int, input().split())

lst = []

if a == 0:
    print(-1)
else:
    delta = b**2 - 4*a*c
    if delta < 0:
        print(0)
    else:
        x1 = (-b + math.sqrt(delta)) / (2*a)
        x2 = (-b - math.sqrt(delta)) / (2*a)
        if isinstance(x1, (int, float)):
            lst.append(x1)
        if isinstance(x2, (int, float)):
            lst.append(x2)
        lst.sort()
        print(len(lst))
        for i in lst:
            print(f"{i:.10f}")
