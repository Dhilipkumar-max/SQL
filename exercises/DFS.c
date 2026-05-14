#include <stdio.h>
#include <stdlib.h>
#include <conio.h>

int sourceV, Vertex, Edge;
int Graph[20][20];
int visited[20];

void DepthFirstSearch(int i)
{
    int j;

    visited[i] = 1;

    printf(" %d ->", i + 1);

    for(j = 0; j < Vertex; j++)
    {
        if(Graph[i][j] == 1 && visited[j] == 0)
        {
            DepthFirstSearch(j);
        }
    }
}

int main()
{
    int i, j, vertex1, vertex2;

    printf("\n\t\t\tGraphs\n");

    printf("Enter number of edges: ");
    scanf("%d", &Edge);

    printf("Enter number of vertices: ");
    scanf("%d", &Vertex);

    for(i = 0; i < Vertex; i++)
    {
        for(j = 0; j < Vertex; j++)
        {
            Graph[i][j] = 0;
        }

        visited[i] = 0;
    }

    for(i = 0; i < Edge; i++)
    {
        printf("Enter the edge (V1 V2): ");
        scanf("%d %d", &vertex1, &vertex2);

        Graph[vertex1 - 1][vertex2 - 1] = 1;
        Graph[vertex2 - 1][vertex1 - 1] = 1;
    }

    printf("\nAdjacency Matrix:\n");

    for(i = 0; i < Vertex; i++)
    {
        for(j = 0; j < Vertex; j++)
        {
            printf(" %d ", Graph[i][j]);
        }

        printf("\n");
    }

    printf("\nEnter source vertex: ");
    scanf("%d", &sourceV);

    printf("\nDFS Traversal:\n");

    DepthFirstSearch(sourceV - 1);

    getch();

    return 0;
}
