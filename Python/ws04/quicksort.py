def zerteilen(x, un, ob):
    piv = x[ob]
    i = un
    for k in range(un,ob):
        if x[k] < piv:
            x[i], x[k] = x[k], x[i]
            i = i+1
    x[i], x[ob] = x[ob], x[i]
        
    return i
    

def quicksort(liste, un = 0, ob = len(x)-1):
    
    if un < ob:
        z = zerteilen(x, un, ob)
        quicksort(x, un, z-1)
        quicksort(x, z+1, ob)
    return x

import random as rd
x = []
for i in range(100):
    x.append(rd.randint(0,1000))

quicksort(x)

