#include <iostream>
#include <vector>
#include <queue>
#include <limits>
#include <algorithm>

using namespace std;

const long long INF = numeric_limits<long long>::max();

struct Edge
{
    int to;
    long long weight;
};

void dijkstra(int n, const vector<vector<Edge>> &graph, vector<long long> &dist, vector<int> &prev)
{
    dist.assign(n + 1, INF);
    prev.assign(n + 1, -1);

    priority_queue<pair<long long, int>, vector<pair<long long, int>>, greater<pair<long long, int>>> pq;
    dist[1] = 0;
    pq.push({0, 1});

    while (!pq.empty())
    {
        int u = pq.top().second;
        long long d = pq.top().first;
        pq.pop();

        if (d > dist[u])
            continue;

        for (const Edge &e : graph[u])
        {
            if (dist[u] + e.weight < dist[e.to])
            {
                dist[e.to] = dist[u] + e.weight;
                prev[e.to] = u;
                pq.push({dist[e.to], e.to});
            }
        }
    }
}

vector<int> reconstructPath(int n, const vector<int> &prev)
{
    vector<int> path;
    for (int v = n; v != -1; v = prev[v])
    {
        path.push_back(v);
    }
    reverse(path.begin(), path.end());
    return path;
}

int main()
{
    int n, m;
    cin >> n >> m;

    vector<vector<Edge>> graph(n + 1);

    for (int i = 0; i < m; ++i)
    {
        int a, b;
        long long w;
        cin >> a >> b >> w;
        graph[a].push_back({b, w});
        graph[b].push_back({a, w});
    }

    vector<long long> dist;
    vector<int> prev;

    dijkstra(n, graph, dist, prev);

    if (dist[n] == INF)
    {
        cout << "-1\n";
    }
    else
    {
        vector<int> path = reconstructPath(n, prev);
        for (int vertex : path)
        {
            cout << vertex << " ";
        }
        cout << "\n";
    }

    return 0;
}
