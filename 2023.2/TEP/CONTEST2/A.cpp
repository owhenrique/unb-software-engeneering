#include <bits/stdc++.h>

using namespace std;

// Fazer MOD

int solve(int N)
{
    while (N > 0)
    {

        if (N % 10 == 7)
        {
            return 1;
            break;
        }

        N /= 10;
    }

    return 0;
}

int main()
{

    int N;

    cin >> N;

    int abs = solve(N);

    if (abs == 1)
        cout << "Yes"
             << "\n";

    else
        cout << "No"
             << "\n";

    return 0;
}