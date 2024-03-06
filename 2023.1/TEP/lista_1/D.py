l, r = map(int, input().split())

x = l
maior = 0

for i in range(l+1, r+1):
    y = x ^ i

    if y > maior:
        maior = y

    x+=1

print(maior)

