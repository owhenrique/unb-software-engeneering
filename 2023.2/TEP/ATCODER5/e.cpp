#include <iostream>
#include <vector>
#include <climits>

using namespace std;

int main() {
    int N, M, L;
    cin >> N >> M >> L;

    vector<long long> a(N);
    vector<long long> b(M);

    for (int i = 0; i < N; ++i) {
        cin >> a[i];
    }

    for (int i = 0; i < M; ++i) {
        cin >> b[i];
    }

    vector<vector<long long>> dp(N + 1, vector<long long>(M + 1, LLONG_MIN));

    dp[0][0] = 0;

    for (int i = 0; i < L; ++i) {
        int c, d;
        cin >> c >> d;
        --c; // Ajusta para índices base 0
        --d;
        dp[c][d] = LLONG_MIN;
    }

    for (int i = 0; i <= N; ++i) {
        for (int j = 0; j <= M; ++j) {
            if (i < N && dp[i][j] != LLONG_MIN) {
                dp[i + 1][j] = max(dp[i + 1][j], dp[i][j] + a[i]);
            }
            if (j < M && dp[i][j] != LLONG_MIN) {
                dp[i][j + 1] = max(dp[i][j + 1], dp[i][j] + b[j]);
            }
        }
    }

    if (dp[N][M] == LLONG_MIN) {
        cout << "0\n";
    } else {
        cout << dp[N][M] << endl;
    }

    return 0;
}
