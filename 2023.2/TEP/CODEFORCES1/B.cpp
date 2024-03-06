#include <iostream>
#include <vector>
using namespace std;

string solve(const string& s) {
    string result;

    for (char c : s) {
        if (c == 'B') {
            if (!result.empty()) {
                for (int i = result.size() - 1; i >= 0; --i) {
                    if (isupper(result[i])) {
                        result.erase(i, 1);
                        break;
                    }
                }
            }
        } else if (c == 'b') {
            if (!result.empty()) {
                for (int i = result.size() - 1; i >= 0; --i) {
                    if (islower(result[i])) {
                        result.erase(i, 1);
                        break;
                    }
                }
            }
        } else {
            result.push_back(c);
        }
    }

    return result;
}

int main() {
    int t;
    cin >> t;
    cin.ignore();

    for (int i = 0; i < t; ++i) {
        string s;
        getline(cin, s);

        string result = solve(s);
        cout << result << endl;
    }

    return 0;
}