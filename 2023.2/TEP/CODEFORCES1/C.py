def minimum_length_after_deletions(t, test_cases):
    results = []

    for i in range(t):
        n, s = test_cases[i]
        stack = []  # Use a stack to keep track of characters

        for char in s:
            if stack and stack[-1] != char:
                # Remove the pair of adjacent different characters
                stack.pop()
            else:
                stack.append(char)

        results.append(len(stack))

    return results

# Input reading
t = int(input())
test_cases = []

for _ in range(t):
    n = int(input())
    s = input().strip()
    test_cases.append((n, s))

# Calculate and print the results
results = minimum_length_after_deletions(t, test_cases)
for result in results:
    print(result)
