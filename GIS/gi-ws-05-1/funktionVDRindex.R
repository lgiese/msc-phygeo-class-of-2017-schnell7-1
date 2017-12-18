mainDir <-
  "C:/Users/Laura/Documents/Uni/Rmsc/Data/GIS/POINTCLOUD_processing"
##input folder
inDir <- "/input/"
## output folder
outDir <- "/temp/vdr/"
## Fusion binary folder
Fusion <- "C:/FUSION/"


vdrIndex = function(Fusion,
                    mainDir,
                    inDir,
                    outDir,
                    extend = "476000 5630000 479000 5633000",
                    cellsize = 1,
                    parameter = 31,
                    del = F) {
  library("rgdal")
  library("raster")
  
  #dann d[rfen nur die 4 las die sp'ter gemerged werden im input ordner sein]
  smallLAS = dir(paste0(mainDir, inDir))
  
  #ordner erstellen wird spaete geloescht
  dir.create(paste0(mainDir, outDir))
  
  las_files <-
    list.files(
      paste0(mainDir, inDir),
      pattern = ".las$",
      full.names = TRUE,
      recursive = TRUE
    )
  ##write the whole file path and name into a .txt
  lapply(las_files,
         write,
         paste0(mainDir, inDir, "lidar_files.txt"),
         append = T)
  
  #infos ueber die .las
  system(
    paste0(
      Fusion,
      "catalog.exe ",
      mainDir,
      inDir,
      "lidar_files.txt " ,
      mainDir,
      outDir,
      "info_caldern.html"
    )
  )
  
  ### Create a .las with groundpoints only
  #.txt --> class_GroundPts.las
  system(
    paste0(
      Fusion,
      "clipdata.exe",
      " /class:2 ",
      mainDir,
      inDir,
      "lidar_files.txt ",
      mainDir,
      outDir,
      "classified_GroundPts.las ",
      extend
    )
  )
  
  ### Create the required PLANS DTM format
  #class_GroundPts.las --> caldernGridSurf.dtm
  system(
    paste0(
      Fusion,
      "gridsurfacecreate.exe ",
      mainDir,
      outDir,
      "caldern_GridSurf.dtm ",
      paste0(cellsize,
             " M M 1 32 0 0 "),
      mainDir,
      outDir,
      "classified_GroundPts.las"
    )
  )
  
  ### normalize heights of las point cloud
  #CaldernGridSurf.dtm --> cald_NORMALIZED_poit_cloud.las
  system(
    paste0(
      Fusion,
      "clipdata.exe",
      " /height /dtm:",
      mainDir,
      outDir,
      "caldern_GridSurf.dtm ",
      mainDir,
      inDir,
      "lidar_files.txt ",
      mainDir,
      outDir,
      "caldern_normalized_point_cloud_LIDAR.las ",
      extend
    )
  )
  
  
  ##canopymodel canopy_surface.dtm
  #normalized_point_cloud --> canopy surface, diese ist CH in der endformel
  system(
    paste0(
      Fusion,
      "canopymodel.exe",
      " /ascii ",
      mainDir,
      outDir,
      "canopy_surfaceX.ascii ",
      paste0(cellsize, " M M 1 32 0 0 "),
      mainDir,
      outDir,
      "caldern_normalized_point_cloud_LIDAR.las "
    )
  )
  
  #dtm2tif_canopymodel
  ##vllt wird hier gestreckt
  #wandelt .dtm in .tif um
  #system(paste0(Fusion, "DTM2TIF.exe ", mainDir, outDir, "canopy_surfaceX.dtm "))
  
  
  ####erstellung von HOMEp50
  
  #wichtig hierbei die csv dateien!
  for (i in 1:4) {
    system(
      paste0(
        Fusion,
        "gridmetrics.exe ",
        "/raster:p50 ",
        mainDir,
        outDir,
        "caldern_GridSurf.dtm ",
        "0 ",
        "1 ",
        mainDir,
        outDir,
        paste0("HOMEsmall", i, ".dtm ") ,
        mainDir,
        inDir,
        smallLAS[i]
      )
    )
  }
  
  #nur mit der csv wird weitergemacht
  for (i in 1:4) {
    system(
      paste0(
        Fusion,
        "CSV2Grid.exe ",
        mainDir,
        outDir,
        paste0("HOMEsmall", i, "_all_returns_elevation_stats.csv "),
        parameter,
        " ",
        mainDir,
        outDir,
        paste0("HOMEsmallbeforeMERGE", i, ".asc ")
      )
    )
  }
  
  #erstellen von txt for merge, einer textdatei fuer den merge
  smallASCs = c()
  for (i in 1:4) {
    a = paste0(mainDir, outDir, "HOMEsmallbeforeMERGE", i, ".asc ")
    a -> smallASCs[i]
  }
  write(x = smallASCs, file = "temp/vdr/txtformerge.txt")
  
  #merged die smalltifraster zu
  system(
    paste0(
      Fusion,
      "MergeRaster.exe ",
      "/overlap:average ",
      mainDir,
      outDir,
      "HOMEp50.asc ",
      mainDir,
      outDir,
      "txtformerge.txt"
    )
  )
  
  #die eigentliche Rechnung
  ch = raster(paste0(mainDir, outDir, "canopy_surfaceX.asc"))
  HOME = raster(paste0(mainDir, outDir, "HOMEp50.asc"))
  origin(HOME)[] <- origin(ch)
  VDR = (ch - HOME) / ch
  VDR@data@values[which(VDR@data@values >= 1)] <- NA
  VDR@data@values[which(VDR@data@values < 0)] <- NA
  
  writeRaster(VDR, "VDR.asc")
  
  file.remove(paste0(mainDir, inDir, "lidar_files.txt"))
  
  if (del == T) {
    file.remove(paste0(mainDir, outDir, dir(paste0(mainDir, outDir))))
  }
  
}