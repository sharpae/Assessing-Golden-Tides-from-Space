# Load the 'raster' library for raster data manipulation
library (sp)
library(raster)

# Set the directory path where the raster files are located
folder_path <- "D:\\LosLances\\NDVI"

# List all raster files in the directory with a .tif extension
rasters_list <- list.files(path = folder_path, pattern = "\\.tif$", full.names = TRUE)

# Load all rasters from the list into a RasterStack
# This allows for the processing of multiple rasters at once
stacked_rasters <- stack(rasters_list)

# Calculate the mean across the raster stack (along the third dimension)
# This computes the mean for each cell across all rasters in the stack, ignoring NA values
mean_raster <- calc(stacked_rasters, fun = mean, na.rm = TRUE)

# Save the resulting raster with the mean values
# Constructs the output file path by appending 'mean_result.tif' to the original folder path
output_path <- paste0(folder_path, "/mean_result.tif")
writeRaster(mean_raster, filename = output_path, format = "GTiff", overwrite = TRUE)

# Print a message indicating where the average raster has been saved
cat("El raster de media ha sido guardado en:", output_path)
