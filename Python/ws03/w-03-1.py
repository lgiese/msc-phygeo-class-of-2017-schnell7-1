import random
import time


## Zahl finden

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
            #print(z)
            n = n+1
        elif z < such:
            #oben = oben
            unten = z
            z = (unten+oben)//2
            #print(z)
            n=n+1
    else:
        zeit2 = time.clock()
        #print("gefunden", z, "mit", n, "Schritten", "tdif=", zeit2-zeit1)
    return(z,n, zeit2-zeit1)	

# sucht alle Zahlen von 1 bis oben
oben=10000
erg=[]
zeit3=time.clock()
for such in range(1,oben):
   a = sucher2(unten = 0, oben = oben, such = such)
   erg.append(a)
zeit4=time.clock()
print(zeit4 - zeit3)
erg


## zeit mittelwert
a = 0
for i in range(0,len(erg)):
    a = a + erg[i][2]

mittel = a/len(erg)

## Schritte mittelwert
b = 0
for i in range(0,len(erg)):
    b = b + erg[i][1]

b/len(erg)

##sd zeit
c = 0 
for i in range(0,len(erg)):
    c = c + (erg[i][2]-mittel)**2
c/len(erg)


## sortierfunktion
b= [5,3,8,1,10,7,2 , 4, 5, 1, 7, 8, 4, 6, 5]
c = ["Hans", "Wurst", "hans", "Apfel", "Äpfel", "äpfe", "äpfel"]

#einmal mit while
def sortwhile(x):
    tmpx = x[:]
    for k in reversed(range(1,len(tmpx))):
        for i in range(k):
            while tmpx[i] > tmpx[i+1]:
                tmpx[i+1], tmpx[i] = tmpx[i], tmpx[i+1] 
    return(tmpx)
    

#einmal mit if 
def sortif(x):
    tmpx = x[:]
    for k in reversed(range(1,len(tmpx))):
        for i in range(k):
            if tmpx[i] > tmpx[i+1]:
                tmpx[i+1], tmpx[i] = tmpx[i], tmpx[i+1] 
    return(tmpx)


b= [5,3,8,1,10,7,2 , 4, 5, 1, 7, 8, 4, 6, 5]
t1 = time.clock()
sortwhile(b)
t2 = time.clock()

b= [5,3,8,1,10,7,2 , 4, 5, 1, 7, 8, 4, 6, 5]
t3 = time.clock()
sortif(b)
t4 = time.clock()

print(t2-t1)
print(t4-t3)

#mit if ist schneller
