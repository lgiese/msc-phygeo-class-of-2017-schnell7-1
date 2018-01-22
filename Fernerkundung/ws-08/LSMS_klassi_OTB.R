setwd('D:/UniData/rms/')
main_dir="D:/UniData/rms/"
in_dir = paste0(main_dir, "data/in/")
out_dir = paste0(main_dir, "data/out/")
source_dir = paste0(main_dir, "scripte/")
file = paste0(in_dir, "geonode_ortho_muf_rgb_idx_pca_scaled.tif")
otbPath = "C:/geo/OSGeo4W64/OTB620/OTB-6.2.0-Win64/bin/"
quo = "\""



#meanshiftsmoothing 
system("C:/geo/OSGeo4W64/OTB620/OTB-6.2.0-Win64/bin/otbcli_MeanShiftSmoothing -in \"D:/UniData/rms/data/in/geonode_ortho_muf_rgb_idx_pca_scaled.tif\" -ram 128 -spatialr 5 -ranger 15 -thres 0.1 -maxiter 100 -rangeramp 0 -fout \"D:/UniData/rms/data/out/fout1.tif\" -foutpos \"D:/UniData/rms/data/out/spout1.tif\" ")

filtered = paste0(out_dir,"fout1.tif")
filtered_pos = paste0(out_dir,"spout1.tif")

#spec_range = 15
system(paste0(otbPath, "otbcli_LSMSSegmentation -in " ,quo, filtered, quo, " -inpos ", quo, filtered_pos, quo, " -out ", out_dir, "LSMSek.tif"," -spatialr 1 -ranger 15 -minsize 0 -tilesizex 256 -tilesizey 256"))
#spec_range = 30
system(paste0(otbPath, "otbcli_LSMSSegmentation -in " ,quo, filtered, quo, " -inpos ", quo, filtered_pos, quo, " -out ", out_dir, "LSMSek30.tif"," -spatialr 1 -ranger 30 -minsize 0 -tilesizex 256 -tilesizey 256"))

#LMSSMallRegionsMerging
#
sek15 = paste0(out_dir, "LSMSek.tif")
sek30 = paste0(out_dir, "LSMSek30.tif")

smallmerge = function(min_size, sek){
  system(paste0(otbPath, "otbcli_LSMSSmallRegionsMerging -in ", quo, file, quo, " -inseg ", quo, sek, quo, " -out ", quo, out_dir, "merged", min_size, ".tif", quo, " -minsize ", min_size, " -tilesizex 250 -tilesizey 250"))
}

smallmerge(40, sek15)
smallmerge(70, sek30)


###############################################################################################
#Nur mit rgb
r = raster(paste0(in_dir, "geonode_ortho_muf_rgb_idx_pca_scaled.tif"), band = 1)
g = raster(paste0(in_dir, "geonode_ortho_muf_rgb_idx_pca_scaled.tif"), band = 2)
b = raster(paste0(in_dir, "geonode_ortho_muf_rgb_idx_pca_scaled.tif"), band = 3)
rgb = stack(r,g,b)
writeRaster(rgb, "data/in/rgb_PCA.tif")

#step1
system("C:/geo/OSGeo4W64/OTB620/OTB-6.2.0-Win64/bin/otbcli_MeanShiftSmoothing -in \"D:/UniData/rms/data/in/rgb_PCA.tif\" -ram 128 -spatialr 5 -ranger 15 -thres 0.1 -maxiter 100 -rangeramp 0 -fout \"D:/UniData/rms/data/out/rgb_fout1.tif\" -foutpos \"D:/UniData/rms/data/out/rgb_spout1.tif\" ")

filtered = paste0(out_dir,"rgb_fout1.tif")
filtered_pos = paste0(out_dir,"rgb_spout1.tif")

#spec_range = 15
system(paste0(otbPath, "otbcli_LSMSSegmentation -in " ,quo, filtered, quo, " -inpos ", quo, filtered_pos, quo, " -out ", out_dir, "rgb_LSMSek.tif"," -spatialr 1 -ranger 15 -minsize 0 -tilesizex 256 -tilesizey 256"))
#spec_range = 30
system(paste0(otbPath, "otbcli_LSMSSegmentation -in " ,quo, filtered, quo, " -inpos ", quo, filtered_pos, quo, " -out ", out_dir, "rgb_LSMSek30.tif"," -spatialr 1 -ranger 30 -minsize 0 -tilesizex 256 -tilesizey 256"))

#LMSSMallRegionsMerging
#
sek15 = paste0(out_dir, "rgb_LSMSek.tif")
sek30 = paste0(out_dir, "rgb_LSMSek30.tif")

smallmerge = function(min_size, sek){
  system(paste0(otbPath, "otbcli_LSMSSmallRegionsMerging -in ", quo, file, quo, " -inseg ", quo, sek, quo, " -out ", quo, out_dir, "merged_rgb", min_size, ".tif", quo, " -minsize ", min_size, " -tilesizex 250 -tilesizey 250"))
}

smallmerge(40, sek15)
smallmerge(70, sek30)