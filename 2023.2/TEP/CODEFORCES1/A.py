def solve(square):
    column, row = square[0], int(square[1])
    
    for c in "abcdefgh":
        if c != column:
            print(c + str(row))
    
    for r in range(1, 9):
        if r != row:
            print(column + str(r))

t = int(input())

for _ in range(t):
    square = input().strip() 
    solve(square)
