# -*- coding: utf-8 -*-
"""
Created on Sat Jan 27 18:23:49 2018

@author: hans
"""
#%%
import math
import gdal, ogr, osr, os
import numpy as np

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
def canigo_fill(start, ar, fill, startval):
    kennichschon=start[:]
    neu=start[:]
    #startval=start[0]
    while len(neu) > 0:
        neu=[]
        for st in range(len(start)):
            for y in range(start[st][0]-1, start[st][0]+2):
                for x in range(start[st][1]-1, start[st][1]+2):
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
    startval = (start[0][0], start[0][1])
    gipfel = False
    while gipfel == False:
        fillv = fillv - dwn_stp
        print(fillv)        
        gval = canigo_fill(start, ar, fillv, startval)
        start = gval[1]
        gipfel = gval[0]
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
    h = float(ar[y][x])
    print("start dom")
    d = dominanzB(y,x,ar,step,res)
    print("start prom")
    p1 = prominenz([(y,x)], ar, dwn_stp)
    p = h-p1[0]
    print("hoehe: ", h, "dominanz: ", d, "prominenz: ", p)
    print("eigenstand: ", eigenstand(h,d,p))
    return(eigenstand(h,d,p), p1[1])
    
#%%subalpen
#gipfel = 113,128
#D:/UniData/py
#/home/hannes/Dokumente/UniMR/py
ar = raster2array("D:/UniData/py/subalpen.tif") 
#%%
estand(113,128,ar,10,200,10)  

#%%harz
#D:/UniData/py
#/home/hannes/Dokumente/UniMR/py
ar = raster2array("D:/UniData/py/harzi.tif")
#woist(1137.05,2,ar)
#%%77,147
estand(77,147, ar, 530, 200, 50)


#%%kufstein
#D:/UniData/py
#/home/hannes/Dokumente/UniMR/py
ar = raster2array("D:/UniData/py/KU_DGM10.asc")
#woist(1593.243042,6,ar)
#%%unteranderem 2611,2998 "Mittagskogel" (1595m)
estand(2611,2998,ar,100, 10, 50)

#%%

#%%

#%%

#%%
