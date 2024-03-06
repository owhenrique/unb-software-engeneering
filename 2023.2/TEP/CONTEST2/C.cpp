#include <bits/stdc++.h>

using namespace std;

int solve(int N)
{
    int sum = 0;
    for (int i = 1; i <= N; i++)
        for (int j = 1; j <= N; j++)
            for (int k = 1; k <= N; k++)
            {
                sum += std::__gcd(std::__gcd(i, j), k);
            }

    return sum;
}

int main()
{

    int N;

    cin >> N;

    cout << solve(N) << endl;
}