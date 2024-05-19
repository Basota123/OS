#include <stdio.h>

static int cache[50] = {0};

int fib(int n)
{
    if (n <= 1) return n;
    if (cache[n] == 0) cache[n] = fib(n-1) + fib(n-2);
    return cache[n];
}


int main()
{

    for (int i = 1; i < 40; i++)
    {
        printf("%d\n", fib(i));
    }


    return 0;
}