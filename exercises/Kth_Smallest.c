#include <limits.h>
#include <stdio.h>
#include <conio.h>

int partition(int arr[], int l, int r);

int kthSmallestelem(int arr[], int l, int r, int K)
{
    if(K > 0 && K <= r - l + 1)
    {
        int pos = partition(arr, l, r);

        if(pos - l == K - 1)
            return arr[pos];

        if(pos - l > K - 1)
            return kthSmallestelem(arr, l, pos - 1, K);

        return kthSmallestelem(arr,
                               pos + 1,
                               r,
                               K - pos + l - 1);
    }

    return INT_MAX;
}

void swap(int* a, int* b)
{
    int temp = *a;

    *a = *b;
    *b = temp;
}

int partition(int arr[], int l, int r)
{
    int j;
    int x = arr[r], i = l;

    for(j = l; j <= r - 1; j++)
    {
        if(arr[j] <= x)
        {
            swap(&arr[i], &arr[j]);

            i++;
        }
    }

    swap(&arr[i], &arr[r]);

    return i;
}

int main()
{
    int arr[100];
    int N, K, i;

    clrscr();

    printf("Enter the No.of Elements:");
    scanf("%d", &N);

    for(i = 0; i < N; i++)
    {
        printf("Enter the Number:");
        scanf("%d", &arr[i]);
    }

    printf("Enter the k th position value:");
    scanf("%d", &K);

    printf("K'th smallest element is %d",
           kthSmallestelem(arr, 0, N - 1, K));

    getch();

    return 0;
}
