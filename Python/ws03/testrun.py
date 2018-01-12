import random
import time

def sucher2(unten, oben, such):
    # such = random.randint(unten, oben)
    n=1
    z=oben/2
    zeit1 = time.clock()
    while z != such:
        if z > such:
            oben = z
            #unten = unten
            z = (unten+oben)//2
            #print("gr")
            n = n+1
        elif z < such:
            #oben = oben
            unten = z
            z = (unten+oben)//2
            #print("kl")
            n=n+1
    else:
        zeit2 = time.clock()
        #print("gefunden", z, "mit", n, "Schritten", "tdif=", zeit2-zeit1)
        #print("ret")
        erg=[]
        erg=z,n
    return(erg)	

def testrunner(lauf, weit, unten=0):
    li = []
    for i in range(lauf):
        zufall = random.randint(1, weit-1)
        #print(zufall)
        li.append(sucher2(unten, weit, zufall))
    return(li) 
   

  
    

print(testrunner(200, 100))
