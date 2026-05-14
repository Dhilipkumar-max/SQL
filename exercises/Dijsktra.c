#include <stdio.h>
#include <conio.h>
#include <limits.h>

#define MAX 20

int minDistance(int dist[], int visited[], int n)
{
    int min = INT_MAX;
    int min_index = -1;
    int i;

    for(i = 0; i < n; i++)
    {
        if(!visited[i] && dist[i] < min)
        {
            min = dist[i];
            min_index = i;
        }
    }

    return min_index;
}

void dijkstra(int graph[MAX][MAX], int n, int src)
{
    int dist[MAX], visited[MAX], parent[MAX], path[MAX];
    int i, j, count, u, v, k, count_path;

    for(i = 0; i < n; i++)
    {
        dist[i] = INT_MAX;
        visited[i] = 0;
        parent[i] = -1;
    }

    dist[src] = 0;

    printf("\nTraversal Order:\n");

    for(count = 0; count < n; count++)
    {
        u = minDistance(dist, visited, n);

        visited[u] = 1;

        printf("%d ", u + 1);

        for(v = 0; v < n; v++)
        {
            if(!visited[v] &&
               graph[u][v] != 0 &&
               dist[u] != INT_MAX &&
               dist[u] + graph[u][v] < dist[v])
            {
                dist[v] = dist[u] + graph[u][v];
                parent[v] = u;
            }
        }
    }

    printf("\n\nVertex\tDistance\tPath\n");

    for(i = 0; i < n; i++)
    {
        printf("%d\t%d\t\t", i + 1, dist[i]);

        count_path = 0;
        j = i;

        while(j != -1)
        {
            path[count_path++] = j + 1;
            j = parent[j];
        }

        for(k = count_path - 1; k >= 0; k--)
        {
            if(k != count_path - 1)
                printf(" -> ");

            printf("%d", path[k]);
        }

        printf("\n");
    }
}

int main()
{
    int graph[MAX][MAX];
    int n, src;
    int i, j;

    clrscr();

    printf("Enter number of vertices: ");
    scanf("%d", &n);

    printf("Enter weighted adjacency matrix:\n");

    for(i = 0; i < n; i++)
    {
        for(j = 0; j < n; j++)
        {
            scanf("%d", &graph[i][j]);
        }
    }

    printf("Enter source vertex: ");
    scanf("%d", &src);

    dijkstra(graph, n, src - 1);

    getch();

    return 0;
}
