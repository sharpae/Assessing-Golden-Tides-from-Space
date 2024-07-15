// Step 1: Import the geometry
// Import a specific geographical area as a FeatureCollection from a Google Earth Engine asset.
var geometry = ee.FeatureCollection("projects/ee-saraharo/assets/coastline_LosLances_32629");


// It is advisable to first visualize the Level 2 Sentinel-2 images in the 'Sentinel Hub EO Browser' to select the appropriate date range in which the image to be processed is located.

// Step 2: Create a filtered image collection
// Create a collection of Sentinel-2 images filtered by date, area of interest, cloud cover, and a specific MGRS tile.
var imgs_s2 = ee.ImageCollection('COPERNICUS/S2_SR')
                  .filterDate('2021-07-01', '2021-07-30') // Filter images by date range.
                  .filterBounds(geometry) // Filter images by the area of interest.
                  .filter(ee.Filter.lt('CLOUDY_PIXEL_PERCENTAGE',10)) // Filter out images with more than 10% cloud cover.
                  .filterMetadata('MGRS_TILE', 'equals', '29SQV') // Filter images by a specific MGRS tile.
                  .map(function(image){return image.clip(geometry)}); // Clip each image to fit the specified geometry.

// Step 3: Print the image collection
// Print the image collection for review in the console.
print(imgs_s2);

// Step 4: Convert the collection to a list and determine its size
// Convert the filtered image collection into a list and retrieve its size.
var lista = imgs_s2.toList(imgs_s2.size());
print("Numero de imagenes:", imgs_s2.size()); // Print the number of images in the collection.

// Step 5: Process each image to calculate NDVI and export the results
// Loop through each image in the list to process and calculate NDVI, then export each result.
for (var step = 0; step < 10; step++) {
  var img = ee.Image(lista.get(step)); // Obtain the current image from the list.

  // Calculate NDVI using the NIR (B8) and Red (B4) bands.
  var ndvi = img.normalizedDifference(['B8','B4']);
  // Create masks for NDVI values greater than 0.08 and less than 1.
  var maskNDVIgt = ndvi.gt(0.08);
  var maskNDVIlt = ndvi.lt(1);
  // Apply masks to the NDVI.
  var maskedNDVI = ndvi.updateMask(maskNDVIgt).updateMask(maskNDVIlt);

  // Extract image ID and generate a name based on the date for the NDVI file.
  var id = img.getInfo().id;
  var nameNDVI = "ndvi_" + id.slice(17, 25); // Extract date from ID for naming.

  Map.centerObject(geometry); // Center the map on the study area.

  // Add the NDVI layer to the map with visual settings.
  Map.addLayer(maskedNDVI, {max:0.3, min: 0, palette:['#DCC5C5','#F3AC8C','#C96346','#622E1E']}, nameNDVI);

  // Export the NDVI image to Google Drive.
  Export.image.toDrive({
    image: maskedNDVI,
    description: nameNDVI,
    scale: 10,
    fileNamePrefix: nameNDVI,
    folder: "R.okamurae",
    maxPixels: 1e13,
    crs: "EPSG:32629",
    region: geometry
  });
}
