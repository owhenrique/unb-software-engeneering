#include <bits/stdc++.h>

using namespace std;

long long int solve(int N)
{
    long long int sum = 0;

    for (int i = 1; i <= N; i++)
    {
        if (i % 3 != 0 && i % 5 != 0)
        {
            sum += i;
        }
    }

    return sum;
}

int main()
{

    long long int N;

    cin >> N;

    cout << solve(N) << "\n";
}