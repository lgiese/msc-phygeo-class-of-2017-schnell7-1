#import von funktionen
import random
import time


#liste mit 1000 Zufallszahlen
ccx = []
for i in range(1000):
    ccx.append(random.randint(0,100000))



#funktion 'sort'; ruft sich selbst in Zeile 25 auf

def sort(x):
    tmpx = x[:]
    tmpgr = []
    tmpkl = []
    tmpxr = []
    for i in range(len(tmpx)):
        if tmpx[0] > tmpx[i]:
            tmpkl.append(tmpx[0+i])
        else:
            tmpgr.append(tmpx[0+i])
    tmpxr = tmpkl + tmpgr
    #print(tmpxr)
    for k in range(len(tmpxr)-1):
        if tmpxr[k] > tmpxr[k+1]:
            tmpxr = sort(tmpxr)
        else:    
            for i in range(len(tmpkl), len(tmpxr)-1):
                if tmpxr[i] > tmpxr[i+1]:
                    tmpxr[i+1], tmpxr[i] = tmpxr[i], tmpxr[i+1]
    return tmpxr
    



#funktion 'sortif', die jedes Listenelement mehrmals bewegt

def sortif(x):
    tmpx = x[:]
    for k in reversed(range(1,len(tmpx))):
        for i in range(k):
            if tmpx[i] > tmpx[i+1]:
                tmpx[i+1], tmpx[i] = tmpx[i], tmpx[i+1] 
    return(tmpx)


    
    
#funktion 'sort2'; trennt mit Hilfe des ersten Listenelements die Liste in einen teil der groesser/kleiner ist und dann wir 'sortif'
#worst-case: groesstes/kleines Listenelement steht an erster Stelle; best-case mittlerstes Element an erster Stelle

def sort2(x):
    tmpx = x[:]
    tmpgr = []
    tmpkl = []
    for i in range(len(tmpx)):
        if tmpx[0] > tmpx[i]:
            tmpkl.append(tmpx[0+i])
        else:
            tmpgr.append(tmpx[0+i])
    tmpxr = tmpkl + tmpgr
    for k in reversed(range(1,len(tmpx))):
        for i in range(k):
            if tmpxr[i] > tmpxr[i+1]:
                tmpxr[i+1], tmpxr[i] = tmpxr[i], tmpxr[i+1]
    return tmpxr


#Geschwindikeitstest

t1 = time.clock()
sort(ccx)
t2 = time.clock()
print("sort", t2-t1)

t3 = time.clock()
sortif(ccx)
t4 = time.clock()
print("sortif", t4-t3)
    
t5 = time.clock()
sort2(ccx)
t6 = time.clock()
print("sort2", t6-t5)    

#test auf gleichheit muss TRUE sein
sortif(ccx) == sort(ccx) == sort2(ccx)


####
#sort 4.352273
#sortif 0.163659
#sort2 0.13845499999999955      
#True                           
################################