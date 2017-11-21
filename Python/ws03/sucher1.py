import random
import time

def sucher(unten, oben):
    such = random.randint(unten, oben)
    n=1
    z=oben/2
    zeit1 = time.clock()
    while z != such:
        if z > such:
            oben = z
            unten = unten
            z = (unten+oben)//2
            print(z)
            n = n+1
        elif z < such:
            oben = oben
            unten = z
            z = (unten+oben)//2
            print(z)
            n=n+1
    else:
        zeit2 = time.clock()
        print("gefunden", z, "mit", n, "Schritten", "tdif=", zeit2-zeit1)
    		
sucher(0,100)
