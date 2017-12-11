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