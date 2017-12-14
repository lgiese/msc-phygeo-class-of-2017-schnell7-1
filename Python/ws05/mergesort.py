def mergesort(lis):
    if len(lis) <= 1:
        return lis
    else:
        links = [x for x in lis[: len(lis)//2]]
        rechts = [x for x in lis[(len(lis)//2) :]]
        
    links = mergesort(links)
    rechts = mergesort(rechts)
    
    return(merge(links, rechts))


def merge(links, rechts):
    erg = []
    while len(links) > 0 and len(rechts) > 0 :
        if links[0] < rechts[0]:
            erg.append(links[0])
            links = links[1:]
        else :
            erg.append(rechts[0])
            rechts = rechts[1:]
            
    erg = [erg+links if len(links) > len(rechts) else erg + rechts]
    
    return(erg[0])


import random as rd
x = []
for i in range(15):
    x.append(rd.randint(0,1000))
z = x[:]


m = mergesort(x)

z, x, m

