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
def canigo_fill(start, ar, fill):
    kennichschon=start[:]
    neu=start[:]
    startval=start[0]
    while len(neu) > 0:
        neu=[]
        for st in range(len(start)):
            for y in range(start[st][0]-1, start[st][0]+2):
                for x in range(start[st][1]-1, start[st][1]+2):
                    if ar[y][x] > ar[startval[0]][startval[1]]:
                        #print("groesseren Punkt gefunden")
                        return(True)
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
        return(False)        

#%%
def prominenz(start, ar, dwn_stp):
    fillv = ar[start[0][0]][start[0][1]]
    gipfel = False
    while gipfel == False:
        fillv = fillv - dwn_stp        
        gipfel = canigo_fill(start, ar, fillv-dwn_stp)
    return(fillv)

#%%
def distanz(z,s,y,x):
    dis = math.sqrt((z-y)**2 + (s-x)**2)    
    return(dis)
#%%
def dominanzB(z,s, dgm_ar, step, res):
    end_list = []
    while len(end_list) == 0:
      for y in range(z-step, z+step+1):
          for x in range(s-step, s+step+1):
              if dgm_ar[z][s] < dgm_ar[y][x]:
                  dissi = distanz(z,s,y,x)
                  end_list.append(dissi)
      step = step+1
    end_list = []
    step = int((step-1) * math.sqrt(2)) + 1
    for y in range(z-step, z+step+1):
          for x in range(s-step, s+step+1):
              if dgm_ar[z][s] < dgm_ar[y][x]:
                  dissi = distanz(z,s,y,x)
                  end_list.append(dissi)                    
    if len(end_list)> 0:
        #print(end_list)
        #print("dominanz: ", min(end_list)*res)
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
    d = dominanzB(y,x,ar,step,res)
    p = float(prominenz([(y,x)], ar, dwn_stp))
    print("hoehe: ", h, "dominanz: ", d, "prominenz: ", p)
    print("eigenstand: ", eigenstand(h,d,p))
    return(eigenstand(h,d,p))
    
#%%subalpen
#gipfel = 113,128

ar = raster2array("/home/hannes/Dokumente/UniMR/py/subalpen.tif") 
#%%
estand(113,128,ar,1,200,20)  

#harz
ar = raster2array("/home/hannes/Dokumente/UniMR/py/harzi.tif")
woist(1137.05,2,ar)
#77,147
estand(77,147, ar, 100, 200, 1)


#%%kufstein
ar = raster2array("/home/hannes/Dokumente/UniMR/py/KU_DGM10.asc")
woist(1593.243042,6,ar)
#unteranderem 2611,2998 "Mittagskogel" (1595m)
estand(2611,2998,ar,100, 10, 50)
#%%
