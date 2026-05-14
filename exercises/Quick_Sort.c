#include <stdio.h>
#include <time.h>

void swap(int *a, int *b)
{
    int t;

    t = *a;
    *a = *b;
    *b = t;
}

int partition(int arr[], int low, int high)
{
    int pivot, i, j;

    pivot = arr[high];
    i = low - 1;

    for(j = low; j <= high - 1; j++)
    {
        if(arr[j] < pivot)
        {
            i++;
            swap(&arr[i], &arr[j]);
        }
    }

    swap(&arr[i + 1], &arr[high]);

    return i + 1;
}

void quickSort(int arr[], int low, int high)
{
    int pi;

    if(low < high)
    {
        pi = partition(arr, low, high);

        quickSort(arr, low, pi - 1);
        quickSort(arr, pi + 1, high);
    }
}

void copyArray(int src[], int dest[], int n)
{
    int i;

    for(i = 0; i < n; i++)
    {
        dest[i] = src[i];
    }
}

void printArray(int arr[], int n)
{
    int i;

    for(i = 0; i < n; i++)
    {
        printf("%d ", arr[i]);
    }
}

int main()
{
    clock_t start, end;
    double time_taken;

    int original[] = {18, 5, 32, 85, 24, 12};
    int arr[6];

    int n = 6;
    int i;

    clrscr();

    printf("Given array:\n");

    printArray(original, n);

    start = clock();

    for(i = 0; i < 10000; i++)
    {
        copyArray(original, arr, n);

        quickSort(arr, 0, n - 1);
    }

    end = clock();

    printf("\n\nSorted array:\n");

    printArray(arr, n);

    time_taken = ((double)(end - start)) / CLOCKS_PER_SEC;

    printf("\n\nTime taken: %lf seconds\n", time_taken);

    getch();

    return 0;
}
