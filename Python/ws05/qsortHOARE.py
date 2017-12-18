def quicksort (x, lo = 0, hi = len(x)-1): 
    if lo < hi: 
        z = zerschneid(x, lo, hi)
        quicksort(x, lo, z) 
        quicksort(x, z+1, hi)
    return x


def zerschneid(x, lo, hi): 
    pivot = x[lo]
    i = lo
    j = hi
    while True: 
        while x[i] < pivot: 
            i = i+1
        while x[j] > pivot: 
            j=j-1
        if i >= j: 
            return(j) 
        x[i],x[j]=x[j],x[i]

import random as rd
x = [rd.randint(0,1000) for i in range(15)]
z = x[:]
q = quicksort(x)


x, z, q

if x != z:
  print("x wurde verändert")