#include <stdio.h>

#define V 4
#define INF 9999

void printSolution(int dist[V][V]);

void floydWarshall(int graph[V][V])
{
    int dist[V][V];
    int i, j, k;

    for(i = 0; i < V; i++
    {
        for(j = 0; j < V; j++)
        {
            dist[i][j] = graph[i][j];
        }
    }

    for(k = 0; k < V; k++)
    {
        for(i = 0; i < V; i++)
        {
            for(j = 0; j < V; j++)
            {
                if(dist[i][k] + dist[k][j] < dist[i][j])
                {
                    dist[i][j] = dist[i][k] + dist[k][j];
                }
            }
        }
    }

    printSolution(dist);
}

void printSolution(int dist[V][V])
{
    int i, j;

    printf("The shortest distances between every pair of vertices\n");

    for(i = 0; i < V; i++)
    {
        for(j = 0; j < V; j++)
        {
            if(dist[i][j] == INF)
            {
                printf("INF ");
            }
            else
            {
                printf("%4d ", dist[i][j]);
            }
        }

        printf("\n");
    }
}

void main()
{
    int graph[V][V] =
    {
        {0, 5, INF, 10},
        {INF, 0, 3, INF},
        {INF, INF, 0, 1},
        {INF, INF, INF, 0}
    };

    clrscr();

    floydWarshall(graph);

    getch();
}
