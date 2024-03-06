def process_key_presses(s):
    lower_indices = [i for i, c in enumerate(s) if c.islower()]
    upper_indices = [i for i, c in enumerate(s) if c.isupper()]

    for char in s[::-1]:
        if char == 'b' and lower_indices:
            index = lower_indices.pop()
            s = s[:index] + s[index + 1:]
        elif char == 'B' and upper_indices:
            index = upper_indices.pop()
            s = s[:index] + s[index + 1:]

    return s


t = int(input())
for _ in range(t):
    s = input().strip()
    result = process_key_presses(s)
    print(result)
