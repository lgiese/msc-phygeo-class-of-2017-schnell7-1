# -*- coding: utf-8 -*-
"""
Created on Sat Jan 27 18:23:49 2018

@author: hans
"""
#%%
import math
import gdal, ogr, osr, os
import numpy as np
import time

#%%
# nach https://pcjericks.github.io/py-gdalogr-cookbook/raster_layers.html#replace-no-data-value-of-raster-with-new-value
def raster2array(rasterfn):
    raster = gdal.Open(rasterfn)
    band = raster.GetRasterBand(1)
    return band.ReadAsArray()

#%%
def woist(wert, r, dmg_ar):
    for y in range(len(ar)):
        for x in range(len(ar[0])):
            if round(float(ar[y][x]), r) == wert:
                print("zeile:", y, "spalte:", x)

#%%
def bestimmung_cfill(start,ar, st):
    if start[st][0]-1< 0:
        y1 = 0
    else:
        y1 = start[st][0]-1
    if start[st][0]+2 >= len(ar):
        y2 = len(ar)-1
    else:
        y2 = start[st][0]+2
    if start[st][1]-1 < 0:
        x1 = 0 
    else:
        x1 = start[st][1]-1
    if start[st][1]+2 >= len(ar[0]):
        x2 = len(ar[0])-1
    else:
        x2 = start[st][1]+2
    return(y1,y2,x1,x2)                  
#%%
def canigo_fill(start, ar, fill, startval):
    kennichschon=start[:]
    neu=start[:]
    #startval=start[0]
    while len(neu) > 0:
        neu=[]
        for st in range(len(start)):
            b = bestimmung_cfill(start,ar,st)
            for y in range(b[0], b[1]):
                for x in range(b[2], b[3]):
                    if ar[y][x] > ar[startval[0]][startval[1]]:
                        #print("groesseren Punkt gefunden")
                        return(True,(startval[0],startval[1]))
                    if ar[y][x] > fill:
                        neu.append((y,x))
                        neu = list(set(neu))
        start=[]
        for i in range(len(neu)):
            if neu[i] not in kennichschon:
                start.append((neu[i][0], neu[i][1]))
                start = list(set(start))
        kennichschon = kennichschon + start
        kennichschon = list(set(kennichschon))
        #print(len(neu), len(kennichschon), len(start))
    else:
        #print("kein weiterer Gipfel")
        return(False, kennichschon)        

#%%
def prominenz(start, ar, dwn_stp):
    fillv = ar[start[0][0]][start[0][1]]
#    fillv = ar[start[0][0]][start[0][1]]-850
    startval = (start[0][0], start[0][1])
    gipfel = False
    while gipfel == False:
        fillv = fillv - dwn_stp
        print(fillv)
        t1 = time.clock()        
        gval = canigo_fill(start, ar, fillv, startval)
        start = gval[1]
        gipfel = gval[0]
        t2 = time.clock()
        print(t2-t1)
    return(fillv, gval[1])

#%%
def distanz(z,s,y,x):
    dis = math.sqrt((z-y)**2 + (s-x)**2)    
    return(dis)
#%%
def bestimmung(z,s,dgm_ar, step):
    if z-step < 0:
        y1 = 0
    else:
        y1 = z-step
    if z+step >= len(dgm_ar):
        y2 = len(dgm_ar)-1
    else:
        y2 = z+step
    if s-step < 0:
        x1 = 0 
    else:
        x1 = s-step
    if s+step >= len(dgm_ar[0]):
        x2 = len(dgm_ar[0])-1
    else:
        x2 = s+step
    return(y1,y2,x1,x2)    
#%%
def dominanzB(z,s, dgm_ar, step, res):
    end_list = []
    while len(end_list) == 0:
        b = bestimmung(z,s,dgm_ar,step)
        for y in range(b[0], b[1]+1):
          for x in range(b[2], b[3]+1):
              if dgm_ar[z][s] < dgm_ar[y][x]:
                  dissi = distanz(z,s,y,x)
                  end_list.append(dissi)
        step = step+1
    end_list = []
    step = int((step-1) * math.sqrt(2)) + 1
    b = bestimmung(z,s,dgm_ar,step)
    for y in range(b[0], b[1]+1):
        for x in range(b[2], b[3]+1):
            if dgm_ar[z][s] < dgm_ar[y][x]:
                  dissi = distanz(z,s,y,x)
                  end_list.append(dissi)                    
    if len(end_list)> 0:
        #print(end_list)
        print("dominanz: ", min(end_list)*res)
        return(min(end_list)*res)
    else:
        print("""Alarm!Alarm!Alarm!Alarm!Alarm!Alarm! \n\n       setze 'step' groesser!\n\n====================================""")

#%%
def eigenstand(h, d, p):
  if d < 100000:
    E1 = math.log(h/8848, 2) + math.log(d/100000, 2) + math.log(p/h, 2)
    E = -(E1/3)
  else:
    E1 = math.log(h/8848, 2) + math.log((p/h), 2)
    E = -(E1/3)
  return(E)
  
#%%
def estand(y,x,ar,step,res, dwn_stp):
    t1=time.clock()
    h = float(ar[y][x])
    print("start dom")
    d = dominanzB(y,x,ar,step,res)
    t3 = time.clock()
    print("dauer ", t3-t1, "start prom")
    p1 = prominenz([(y,x)], ar, dwn_stp)
    p = h-p1[0]
    t4 = time.clock()
    print("dauer: ", t4-t3, "hoehe: ", h, "dominanz: ", d, "prominenz: ", p)
    t2=time.clock()
    print("eigenstand: ", eigenstand(h,d,p), "in:", (t2-t1)/3600," stunden")
    return(eigenstand(h,d,p), p1[1])
#%%
    
    
    
    
    
    
    
############################### subalpen ######################################    
#%%schnell
#subalpen
#gipfel = 113,128
#D:/UniData/py
#/home/hannes/Dokumente/UniMR/py
#ar = raster2array("D:/UniData/py/raster/subalpen.tif") 
#%%
#estand(113,128,ar,10,200,10)  
#hoehe:  2215.197998046875 dominanz:  3492.8498393145956 prominenz:  800.0
#eigenstand:  2.7689103496323155 in: 0.0006940085095782493  stunden













#%%############################ brocken #######################################
#sehr lange
#harz-brocken
#D:/UniData/py/raster
#/home/hannes/Dokumente/UniMR/py
ar = raster2array("D:/UniData/py/raster/harzi.tif")
woist(1137.05,2,ar)
#%%77,147
estand(77,147, ar, 530, 200, 128)
#hoehe:  1137.050048828125 
#dominanz:  223070.30281953712 dauer  102 sek
#prominenz:  860.0
#eigenstand:  1.1209809402150823
# literaturwerte 
#%%https://de.wikipedia.org/wiki/Brocken
#eigenstand(1141.2, 224000, 856)
#http://www.peakbagger.com/list.aspx?lid=4343
#eigenstand(1141  , 223100, 856)
#1.1232228946111869
#eigenstand(1141,223070,856)

#%%#############################################################################################################
#800er 1085.3502
ar = raster2array("D:/UniData/py/raster/harz_800.tif")
#woist(1085.3502,4,ar)
#zeile: 19 spalte: 36
#%%
estand(19,36, ar, 25, 800, 128)
#%%
hoehe:  1085.3502197265625 dominanz:  223442.1625387653 prominenz:  800.0
eigenstand:  1.1557598268199942 in: 0.015637430981284728  stunden


#================================== mti alt modul ================

hoehe:  1085.3502197265625 dominanz:  223442.1625387653 prominenz:  798.0
eigenstand:  1.1569635780041205 in: 0.047212657587386075  stunden

liefert aber gutes ergebnis fuer prominenz (853, wenn mit richtigen werten fuer hoehe gerechnet worden waere)
 
1085.3 -798
Out[185]: 287.29999999999995

1141-287.3
Out[186]: 853.7

#%%#############################################################################################################
#400er 1137.05
ar = raster2array("D:/UniData/py/raster/harz_400.tif")
woist(1137.05,2,ar)
#zeile: zeile: 38 spalte: 73
#%%
estand(38,73, ar, 25, 400, 128)
#%%
hoehe:  1137.050048828125 dominanz:  223221.86272854186 prominenz:  850.0
eigenstand:  1.1266055464032145 in: 0.5319227187108573  stunden




#%%###########################################################################################################
#600er 1137.05
ar = raster2array("D:/UniData/py/raster/harz_600.tif")
woist(1107.099,3,ar)
#zeile: zeile: 25 spalte: 48
#%%
estand(25,48, ar, 25, 600, 128)
#%%
hoehe:  1107.0989990234375 dominanz:  223684.95702661815 prominenz:  830.0
eigenstand:  1.13805604800014 in: 0.08232859853469159  stunden
#=========================================== mit alternierend ==============================
hoehe:  1107.0989990234375 dominanz:  223684.95702661815 prominenz:  822.0
eigenstand:  1.1427136955176749 in: 0.16057810848656826  stunden

wieder falsche hoehe; mit richtiger p=856 , das ist der literaturwert


#%%################################################################################################################
#1000er 1137.05
ar = raster2array("D:/UniData/py/raster/harz_eintausend.tif")
woist(1137.05,2,ar)
#zeile: 15 spalte: 29
#%%
estand(15,29, ar, 25, 1000, 128)
#%%
hoehe:  1137.050048828125 dominanz:  223331.59203301265 prominenz:  850.0
eigenstand:  1.1266055464032145 in: 0.009963159426572221  stunden

#===== mit alternierenden ansatz ===================================================================

hoehe:  1137.050048828125 dominanz:  223331.59203301265 prominenz:  846.0
eigenstand:  1.1288739390382525 in: 0.018778400191671003  stunden

mit richtiger hoehe p = 852










#%%############################# kufstein #####################################
#kufstein
#D:/UniData/py
#/home/hannes/Dokumente/UniMR/py
ar = raster2array("D:/UniData/py/raster/KU_DGM10.asc")
#%%
#woist(1787.980957,6,ar)
#zeile: 1934 spalte: 1590
#
#%%
estand(1934,1590,ar,100, 10, 20)



#%%############################# taunus #######################################
#6std
#taunus-gr feldberg
#D:/UniData/py
#/home/hannes/Dokumente/UniMR/py
ar = raster2array("D:/UniData/py/raster/taunus.tif")
#woist(875.4925,4,ar)
#%%420,154
estand(420,154, ar, 50, 200, 128)
#%%
#hoehe:  875.4924926757812 dominanz:  101482.01811158466 prominenz:  670.0
#eigenstand:  1.2410394616298575
#http://www.thehighrisepages.de/bergtouren/na_tauns.htm
#h=879 estand=1,24 dom=101000 p=670
	


#%%sehr schnell
#taunus-kl feldberg 
#woist(821.2731,4,ar)
#zeile: 425 spalte: 150
#estand(425,150, ar, 1, 200, 128)
#hoehe:  821.2730712890625 dominanz:  1000.0 prominenz:  33.0
#eigenstand:  4.903532580216993
##http://www.thehighrisepages.de/bergtouren/na_tauns.htm
#h=825 estand=4,91 dom=930 p=35
	
#%%sehr schnell
#taunus-winterstein 
#woist(509.52810669, 8, ar)
#zeile: 367 spalte: 227
#estand(367,227, ar, 1, 200, 128)
#hoehe:  509.5281066894531 dominanz:  10065.783625729295 prominenz:  164.0
#eigenstand:  3.02201742314082
#http://www.thehighrisepages.de/bergtouren/na_tauns.htm
#Steinkopf (Höchster Punkt im  Winterstein-Taunuskamm)
#h=518 estand=2,99 dom=10170  p=173
#%%sehr schnell
#taunus - johannisberg
#267.4231
#woist(267.4231,4,ar)
#zeile: 344 spalte: 247
estand(344,247,ar,1,200,128)
#hoehe:  267.423095703125 dominanz:  3000.0 prominenz:  23.0
#eigenstand:  4.548822467743755
#
#%%
#maxima im muf
#289.6425
#woist(398.55371094,8,ar)
#zeile: 84 spalte: 232
estand(84,232,ar,1,200,128)
#hoehe:  398.5537109375 dominanz:  2236.06797749979 prominenz:  65.0
#eigenstand:  4.190553333179099



#%%------------------------------------------------------------------------------------------------------------------
#http://www.peaklist.org/lists.html
#subalpen,harz und taunus geodatenzentrum.de 
#Auflösung : Lage: 200 m Höhe: 0,01 m 
#Genauigkeit : Lage:  +- 5 m       Höhe: +- 3 – 10 m  