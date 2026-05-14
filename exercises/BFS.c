#include <stdio.h>
#include <conio.h>

#define MAX 20

int adj[MAX][MAX], visited[MAX], queue[MAX];
int front = 0, rear = 0, n;

void enqueue(int v)
{
    queue[rear++] = v;
}

int dequeue()
{
    return queue[front++];
}

void BFS(int start)
{
    int i, v;

    enqueue(start);
    visited[start] = 1;

    while(front < rear)
    {
        v = dequeue();
        printf("%d ", v);

        for(i = 0; i < n; i++)
        {
            if(adj[v][i] == 1 && visited[i] == 0)
            {
                enqueue(i);
                visited[i] = 1;
            }
        }
    }
}

void main()
{
    int i, j, start;

    clrscr();

    printf("Enter number of vertices: ");
    scanf("%d", &n);

    printf("Enter adjacency matrix:\n");

    for(i = 0; i < n; i++)
    {
        for(j = 0; j < n; j++)
        {
            scanf("%d", &adj[i][j]);
        }
    }

    for(i = 0; i < n; i++)
    {
        visited[i] = 0;
    }

    printf("Enter starting vertex (0 to %d): ", n - 1);
    scanf("%d", &start);

    printf("\nBFS Traversal: ");

    BFS(start);

    getch();
}
