# Introduction:
# Prior to this script, all NDVI rasters were processed in Google Earth Engine. They were downloaded from 
# Google Drive and converted into vector layers using QGIS software. This script continues from there 
# to manage these vector layers using R.

# Load the 'sf' library for handling spatial data
library(sf)

# Set the working directory to where the shapefiles are located (if not already set)
setwd("E:\\LosLances\\NDVI\\polygons")

# List all shapefiles in the directory using a pattern to match files ending in .shp
shapefiles <- list.files(pattern = "\\.shp$")

# Initialize a list to store polygons from each shapefile
all_polygons <- list()

# Loop through each shapefile, read it, and store the polygons in the list
for (shp_file in shapefiles) {
  # Read the current shapefile
  shp <- st_read(shp_file)
  # Append the read shapefile (polygon data) to the list
  all_polygons[[length(all_polygons) + 1]] <- shp
}

# Combine all polygons into a single layer using rbind
combined_polygons <- do.call(rbind, all_polygons)

# Save the combined layer as a new shapefile
output_file <- "combined_polygons_all.shp"
st_write(combined_polygons, output_file)

# Print a message confirming that all polygons have been combined into one layer
print("Todos los polígonos han sido combinados en una sola capa!")

#####################################################################
# Additional Part: Dissolving/Agglomerating All Polygons into One

# Load necessary libraries for spatial data and data manipulation
library(sf)
library(dplyr)

# Load the combined polygons layer
shape_path <- "E:/LosLances/NDVI/polygons/combined_polygons_all.shp"
polygons <- st_read(shape_path)

# Dissolve/agglomerate all polygons into one using dplyr's summarize and st_union
dissolved_polygons <- polygons %>% 
  summarize(geometry = st_union(geometry), do_union = FALSE) 

# Save the dissolved polygon layer in the same location
output_path <- "E:/LosLances/NDVI/polygons/dissolved_polygon.shp"
st_write(dissolved_polygons, output_path)

# Print the path where the dissolved polygon has been saved
cat("El polígono disuelto ha sido guardado en:", output_path)

#####################################################################
# Final Steps:
# The final shapefile was opened in QGIS, where the largest patches were selected and exported. Subsequently, the script continues:

# Definition of the path for the shapefile
shape_path <- "E:/LosLances/NDVI/polygons/east_polygon.shp"

# Read the shapefile using 'sf'
polygons <- st_read(shape_path)

# Dissolve/agglomerate all polygons into one
east_polygon_dissolved <- polygons %>% 
  summarize(geometry = st_union(geometry), do_union = FALSE) 

# Save the result in the same location, renaming it to avoid overwriting the original
output_path <- "E:/LosLances/NDVI/polygons/east_polygon_dissolved.shp"
st_write(east_polygon_dissolved, output_path)

# Print a message confirming that the dissolved polygon has been saved
cat("El polígono disuelto ha sido guardado en:", output_path)
