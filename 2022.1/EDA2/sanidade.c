#include <stdio.h>
#include <stdlib.h>

#define ull unsigned long long
#define Item struct Element
#define key(x) (x.atual)
#define less(a, b) (key(a) < key(b))
#define exch(a, b)  {Item t = a; a = b;b = t;}
#define cmpexch(a, b) {if (less(a, b)) exch(a, b);}

struct Element
{
    ull atual, anterior, proximo;
};

int partition(Item *v, int size)
{
    int l = -1, r = size - 1;
    Item pivo = v[r];

    while (1)
    {
        while (less(v[++l], pivo));
        while (less(pivo, v[--r]) && r > l);

        if (l >= r)
            break;
        exch(v[l], v[r]);
    }
    exch(v[l], v[size - 1]);
    return l;
}

void quicksort(Item *v, int size)
{
    if (size < 2)
        return;

    cmpexch(v[(size - 1) / 2], v[size - 1]);
    cmpexch(v[0], v[(size - 1) / 2]);
    cmpexch(v[size - 1], v[(size - 1) / 2]);

    int m = partition(v, size);
    quicksort(v, m);
    quicksort(v + m + 1, size - m - 1);
}

int search(Item *v, int n, ull x)
{
    int l = 0, r = n - 1;
    while (l <= r)
    {
        int m = (l + r) / 2;
        if (key(v[m]) == x)
            return m;
        else if (key(v[m]) < x)
            l = m + 1;
        else
            r = m - 1;
    }
    return -1;
}

int is_sane(Item *v, int n, Item anterior, Item alvo)
{
    if (anterior.proximo == alvo.atual && alvo.anterior == anterior.atual)
        return 1;

    int idx = search(v, n, anterior.proximo);
    if (idx == -1 || v[idx].anterior != anterior.atual)
        return 0;

    return is_sane(v, n, v[idx], alvo);
}

Item v[500000];

int main()
{
    int n;
    for (n = 0; scanf(" %llx %llx %llx", &v[n].atual, &v[n].anterior, &v[n].proximo) == 3; n++);

    Item ptr1 = v[0], ptr2 = v[1];
    quicksort(v, n);

    printf("%s\n", (is_sane(v, n, ptr1, ptr2) ? "sana" : "insana"));

    return 0;
}