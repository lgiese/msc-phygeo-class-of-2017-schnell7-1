
#%%
import math
import gdal, ogr, osr, os
import numpy as np
# props an https://pcjericks.github.io/py-gdalogr-cookbook/raster_layers.html#replace-no-data-value-of-raster-with-new-value
def raster2array(rasterfn):
    raster = gdal.Open(rasterfn)
    band = raster.GetRasterBand(1)
    return band.ReadAsArray()

#%%
dgm = gdal.Open("D:/UniData/py/subalpen.tif")
#%%
ar = raster2array("D:/UniData/py/subalpen.tif")
#%%
#gipfelsuche entweder im gis oder hiermit
for y in range(len(ar)):
    print(y, max(ar[y]))
#%%
#vermeintliche gipfelhoehe als zahl eingeben
#dateityp des arrays (float32) ist anders als float (2041.27 z.B.), logische abfragen in py daher immer FALSE
for y in range(len(ar)):
    if round(float(max(ar[y])), 2) == 2041.27 :
        print(y, max(ar[y]))
        for x in range(len(ar[0])):
            if round(float(ar[y][x]), 2) == 2041.27:
                print("zeile:", y, "spalte:", x)
    
#%%
#nur so
dgm = gdal.Open("D:/UniData/py/subalpen.tif")

#%%
#z,s, gipfelkoordinaten, y,x von dominanz()
def distanz(z,s,y,x):
    dis = math.sqrt((z-y)**2 + (s-x)**2)    
    return(dis)

#zeile, spalte(des gipfels), array des dgm, step grosse des fensters minimale dis wird ausgesucht, res = zellengroesse
def dominanz(z,s, dgm_ar, step, res):
    end_list = []
    di = 1
    for y in range(z-step, z+step+1):
        for x in range(s-step, s+step+1):
            if dgm_ar[z][s] < dgm_ar[y][x]:
                dissi = distanz(z,s,y,x)
                end_list.append(dissi)
                
    if len(end_list)> 0:
        print(end_list)
        return(min(end_list)*res)
        

        
        
#%%


#%%
dominanz(78,60,ar,5,200)
    
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
 #300 wird hier yum test angenommen
 #gipfel hat nahegelegen hoeheren gipfelnachbar deswegen reicht 5 (3 ginge auch)
h = float(ar[78][60])
d = dominanz(78,60,ar,5,200)
eigenstand(h, 300, d)
#%%
#naechster hoeherer gipfel viel wieter weg; step deswegen 55 (53 geht auch)
h2 = float(ar[80][65])
d2 = dominanz(80,65,ar,55,200)
eigenstand(h2, 300, d2)