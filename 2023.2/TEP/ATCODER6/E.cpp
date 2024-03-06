#include <iostream>
#include <vector>

using namespace std;

vector<vector<int>> graph;
vector<bool> visited;

void dfs(int node) {
    visited[node] = true;
    for (int neighbor : graph[node]) {
        if (!visited[neighbor]) {
            dfs(neighbor);
        }
    }
}

int solve(int n, vector<pair<int, int>>& laces) {
    graph.resize(n + 1);
    visited.resize(n + 1, false);

    for (const auto& lace : laces) {
        int a = lace.first;
        int b = lace.second;
        graph[a].push_back(b);
        graph[b].push_back(a);
    }

    int groups = 0;

    for (int i = 1; i <= n; i++) {
        if (!visited[i]) {
            dfs(i);
            groups++;
        }
    }

    return (groups == 0) ? 1 : groups;
}

int main() {
    int n, m;
    cin >> n >> m;

    vector<pair<int, int>> laces(m);

    for (int i = 0; i < m; i++) 
        cin >> laces[i].first >> laces[i].second;

    int groups = solve(n, laces);

    cout << groups - 1 << endl;

    return 0;
}
