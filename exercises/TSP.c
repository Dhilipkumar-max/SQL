#include<stdio.h>
#include<conio.h>

int a[10][10], n, visit[10];
int cost_opt = 0, cost_apr = 0;

int least_apr(int c);
int least_opt(int c);

void mincost_opt(int city)
{
    int ncity;

    visit[city] = 1;

    printf("%d-->", city);

    ncity = least_opt(city);

    if(ncity == 999)
    {
        ncity = 1;

        printf("%d", ncity);

        cost_opt += a[city][ncity];

        return;
    }

    mincost_opt(ncity);
}

void mincost_apr(int city)
{
    int ncity;

    visit[city] = 1;

    printf("%d-->", city);

    ncity = least_apr(city);

    if(ncity == 999)
    {
        ncity = 1;

        printf("%d", ncity);

        cost_apr += a[city][ncity];

        return;
    }

    mincost_apr(ncity);
}

int least_opt(int c)
{
    int i, nc = 999;
    int min = 999, kmin = 999;

    for(i = 1; i <= n; i++)
    {
        if((a[c][i] != 0) && (visit[i] == 0))
        {
            if(a[c][i] < min)
            {
                min = a[i][1] + a[c][i];
                kmin = a[c][i];
                nc = i;
            }
        }
    }

    if(min != 999)
        cost_opt += kmin;

    return nc;
}

int least_apr(int c)
{
    int i, nc = 999;
    int min = 999, kmin = 999;

    for(i = 1; i <= n; i++)
    {
        if((a[c][i] != 0) && (visit[i] == 0))
        {
            if(a[c][i] < kmin)
            {
                min = a[i][1] + a[c][i];
                kmin = a[c][i];
                nc = i;
            }
        }
    }

    if(min != 999)
        cost_apr += kmin;

    return nc;
}

void main()
{
    int i, j;

    clrscr();

    printf("Enter No. of cities:\n");
    scanf("%d", &n);

    printf("Enter the cost matrix\n");

    for(i = 1; i <= n; i++)
    {
        printf("Enter elements of row:%d\n", i);

        for(j = 1; j <= n; j++)
        {
            scanf("%d", &a[i][j]);
        }

        visit[i] = 0;
    }

    printf("The cost list is \n");

    for(i = 1; i <= n; i++)
    {
        printf("\n");

        for(j = 1; j <= n; j++)
        {
            printf("\t%d", a[i][j]);
        }
    }

    printf("\n\nOptimal Solution :\n");

    printf("\nThe path is :\n");

    mincost_opt(1);

    printf("\nMinimum cost:");

    printf("%d", cost_opt);

    printf("\n\nApproximated Solution :\n");

    for(i = 1; i <= n; i++)
    {
        visit[i] = 0;
    }

    printf("\nThe path is :\n");

    mincost_apr(1);

    printf("\nMinimum cost : ");

    printf("%d", cost_apr);

    printf("\n\nError in approximation is approximated solution / optimal solution = %f",
           (float)cost_apr / cost_opt);

    getch();
}
