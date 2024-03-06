#include <bits/stdc++.h>

using namespace std;

int solve(int numVertices, int numEdges, vector<int>& a, vector<int>& b) {
    vector<vector<int>> adjList(numVertices + 1);

    for (int i = 0; i < numEdges; i++) {
        adjList[a[i]].push_back(b[i]);
        adjList[b[i]].push_back(a[i]);
    }

    queue<int> q;
    vector<bool> visited(numVertices + 1, false);

    q.push(1);
    visited[1] = true;

    int distance = 0;

    while (!q.empty()) {
        int levelSize = q.size();

        for (int i = 0; i < levelSize; i++) {
            int island = q.front();
            q.pop();

            if (island == numVertices)
                return distance;

            for (int neighbor : adjList[island]) {
                if (!visited[neighbor]) {
                    visited[neighbor] = true;
                    q.push(neighbor);
                }
            }
        }

        distance++;
    }

    return -1;
}

int main() {
    int N, M;
    cin >> N >> M;

    vector<int> a(M);
    vector<int> b(M);

    for (int i = 0; i < M; i++)
        cin >> a[i] >> b[i];

    int result = solve(N, M, a, b);

    if (result != -1 && result <= 2)
        cout << "POSSIBLE" << "\n";
    else
        cout << "IMPOSSIBLE" << "\n";

    return 0;
}
