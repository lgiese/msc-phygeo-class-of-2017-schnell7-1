def sort(y):
  if len(y) <= 1:
    return(y)
  kl = [x for x in y[1:] if x < y[0]]
  gr = [x for x in y[1:] if x >= y[0]]
  return(sort(kl) + [y[0]] + sort(gr))

def array2raster(rasterfn,newRasterfn,array):
    raster = gdal.Open(rasterfn)
    geotransform = raster.GetGeoTransform()
    originX = geotransform[0]
    originY = geotransform[3]
    pixelWidth = geotransform[1]
    pixelHeight = geotransform[5]
    cols = raster.RasterXSize
    rows = raster.RasterYSize

    driver = gdal.GetDriverByName('GTiff')
    outRaster = driver.Create(newRasterfn, cols, rows, 1, gdal.GDT_Float32)
    outRaster.SetGeoTransform((originX, pixelWidth, 0, originY, 0, pixelHeight))
    outband = outRaster.GetRasterBand(1)
    outband.WriteArray(array)
    outRasterSRS = osr.SpatialReference()
    outRasterSRS.ImportFromWkt(raster.GetProjectionRef())
    outRaster.SetProjection(outRasterSRS.ExportToWkt())
    outband.FlushCache()


#%%
def canigo(start, ar, startval):
    kennichschon=start[:]
    neu=start[:]
    #startval=start[0]
    while len(neu) > 0:
        neu=[]
        b=[]
        for st in range(len(start)):
            for y in range(start[st][0]-1, start[st][0]+2):
                for x in range(start[st][1]-1, start[st][1]+2):
                    if ar[y][x] > ar[startval[0]][startval[1]]:
                        #print("groesseren Punkt gefunden")
                        return(True)                    
                    neu.append([(y,x), ar[y][x]])
            g=[]
            for i in range(len(neu)):
                if neu[i][0] not in kennichschon:
                    g.append(neu[i][1])
            if len(g) > 0:
                b.append([neu[i][0] for i in range(len(neu)) if neu[i][1] == max(g)])
            else:
                return(False, kennichschon)
        b = b[0]
                
        start=[]
        for i in range(len(neu)):
            if neu[i] not in kennichschon:
                start.append((neu[i][0], neu[i][1]))
                start = list(set(start))
        kennichschon = kennichschon + b
        kennichschon = list(set(kennichschon))
        start = b[:]
        print(len(neu), len(kennichschon), len(start))
    else:
        #print("kein weiterer Gipfel")
        return(False)        

#%%
def prominenz(start, ar):

    init = False
    gipfel = False
    
    while gipfel == False:
            gipfel = canigo(canigo(start,ar)[1], ar)[0]
            
            init=True
   

    print("gur", (t2-t1)/60, "min")
    return("findung")

















#%%subalpen
#gipfel = 113,128

ar = raster2array("/home/hannes/Dokumente/UniMR/GIT/Python/ws09/subalpen.tif") 
#%%
estand(113,128,ar,1,200,5)  
start = [(2611, 2998)]


        
        
        
        
        
###############################3
#estand(113,128,ar,1,200,5)
###############################
#%%subalpen
#gipfel = 113,128

ar = raster2array("/home/hannes/Dokumente/UniMR/GIT/Python/ws09/subalpen.tif") 
canigo([(113,128)],ar)




#####################
ar = raster2array("/home/hannes/Dokumente/UniMR/py/harzi.tif")
woist(1137.05,2,ar)
canigo([(77,147)], ar)



######################################
#%%kufstein
woist(1593.243042,6,ar)
#unteranderem 2611,2998 "Mittagskogel" (1595m)
#
#%%

ar = raster2array("/home/hannes/Dokumente/UniMR/py/KU_DGM10.asc")

prominenz([(2611,2998)], ar)
erster = canigo([(2611, 2998)],ar, (2611, 2998))
zwe = canigo(erster[1], ar, (2611, 2998))
d1= canigo(zwe[1], ar, (2611, 2998))
d2 = canigo(d1[1], ar, (2611, 2998))
d3 = canigo(d2[1], ar, (2611, 2998))
d3[1] == d2[1]





ar2=ar[:]

for y in range(len(ar)):
    for x in range(len(ar[0])):
        if (y, x) in d2[1]:
            ar2[y][x] = 1
        else:
            ar2[y][x] = 0
            
            

arsave = ar2[:]

array2raster("/home/hannes/Dokumente/UniMR/py/KU_DGM10.asc","/home/hannes/Dokumente/UniMR/py/gelaufenKU_DGM10.asc",ar2)