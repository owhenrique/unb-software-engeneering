#include <iostream>
#include <string>

using namespace std;

int main() {
    int t;
    cin >> t;

    while (t--) {
        int n;
        cin >> n;

        string s;
        cin >> s;

        int result = 0;
        for (int i = 1; i < n; ++i) {
            if (s[i] == s[i - 1]) {
                result++;
                i++; // Skip the next character since it's part of the pair
            }
        }

        cout << result << endl;
    }

    return 0;
}
