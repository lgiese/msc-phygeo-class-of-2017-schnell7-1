def sort(y):
  if len(y) <= 1:
    return(y)
  kl = [x for x in y[1:] if x < y[0]]
  gr = [x for x in y[1:] if x >= y[0]]
  return(sort(kl) + [y[0]] + sort(gr))

import random as rd
x = []
for i in range(100):
  x.append(rd.randint(0,1000))
  
  
z = x[:]  
sort(x)

[A for i in range len A if A[-1] > A[-1-i]]




def quicksort(A): 
    for x in range(len(A)): 
        wall = - [-i-1 for i in range(len(A)) if A[-1] > A[-1-i]][0]
        for i in range(len(A)):
            piv = A[-1]
            lookat = A[i]
            if lookat < piv: 
                A[i], A[wall] = A[wall], A[i]  #positions to swap
                wall += 1
        #swap pivot and wall position
        A[-1], A[wall] = A[wall], A[-1]
                  
    return A 
    
    
[-i-1 for i in range(len(A)) if A[-1] > A[-1-i]]

[-i-1 for i in range(len(x)) if x[-1-i] > x[-2-i+1]]
x = [1,11, 9, 8, 19, 21, 25, 31]


[i for i in range(len(x)-1, -1, -1) if x[i] > x[i-1]]
[i if x[i] > x[i-1] else pass for i in range(len(x)-1, -1, -1) ]