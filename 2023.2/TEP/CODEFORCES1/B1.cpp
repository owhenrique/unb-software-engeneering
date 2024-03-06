#include <iostream>
#include <stack>
using namespace std;

string solve(const string& s) {
    stack<char> result;

    for (char c : s) {
        if (c == 'B') {
            if (!result.empty()) {
                result.pop();
            }
        } else if (c == 'b') {
            if (!result.empty()) {
                while (!result.empty() && islower(result.top())) {
                    result.pop();
                }
            }
        } else {
            result.push(c);
        }
    }

    string typedString;
    while (!result.empty()) {
        typedString = result.top() + typedString;
        result.pop();
    }

    return typedString;
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
