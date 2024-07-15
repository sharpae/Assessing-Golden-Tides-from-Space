# Assessing-Golden-Tides-from-Space
**Monitoring Invasive Algae *Rugulopteryx okamurae* on Coastal Areas using Sentinel-2 imagery**

Cloud-free Sentinel-2 multispectral satellite images obtained at low tide were manually selected from the Sentinel Hub EO Browser (Figure 1; step 1). A total of 130 Sentinel-2 images (Level 2A) from 2018 to 2022 were analyzed using the Normalized Difference Vegetation Index (NDVI). The NDVI was computed using the red surface reflectance bands (sr_B4) and near-infrared (sr_B8) as follows: NDVI = (sr_B8 – sr_B4) / (sr_B8 + sr_B4), where band 8 (B8) corresponds to reflectance at 850 nm and band 4 (B4) to reflectance at 650 nm. NDVI is often used as a proxy for biomass to study intertidal photosynthetic communities, such as microphytobenthos, seagrass, or seaweeds, during low tides [1–3]. Pixels with NDVI values above 0.08 were used to identify the presence of *R. okamurae* washed ashore (Figure 1; step 3). This methodology, proposed by Haro et al. (2023), monitors golden seaweed tides accumulated along the shoreline in the absence of other primary producers and has been validated for mapping *R. okamurae* in a nearby area [4,5].

Google Earth Engine (GEE), a cloud-based geospatial analysis platform, was employed to download NDVI images filtered with values above 0.08 from 2018 to 2022 (see GEE script). The "Sentinel-2 MSI: MultiSpectral Instrument, Level-2A" image collection (available from March 2017) was utilized for tile 29SQV, using a shapefile to define the area of interest (Figure 1; step 2). All scenes were aligned in the WGS 84/UTM zone 29 N coordinate system (EPSG: 32629).

![image](https://github.com/user-attachments/assets/dac0d47a-faf4-4a9d-a128-129a01b1c95e)

**Figure 1** illustrates the proposed methodology for monitoring *R. okamurae* strandings accumulated along the coastline, encompassing five steps: (Step 1) Visualization and selection of Sentinel-2 imagery for processing; (Step 2) Creation of the area of interest along the entire coastline; (Step 3) Processing of Sentinel-2 images using Google Earth Engine; (Step 4) Selection of the largest patches with seaweed accumulations; and (Step 5) Calculation of coverage and average NDVI for the entire coastline and for the largest patches using geographic information system (GIS).

*R. okamurae* coverage was determined by the number of pixels with NDVI values above 0.08. Coverage and average NDVI of *R. okamurae* along the coastline were calculated using the "Zonal statistics" plugin in QGIS software (version 3.10 A Coruña) (Figure 1; step 5). In addition to the area of interest (see shapefile folder), two other vector layers were created for spatial analysis. To analyze spatial variability and identify the areas with maximum extensions of *R. okamurae*, the mean of all images or rasters (NDVI > 0.08) was calculated (see Rstudio script, “Mean rasters”) using the “raster” and “sp” libraries in Rstudio (version 2022.07.2 + 576). All rasters were transformed into vector layers and combined to delineate the largest patches (Figure 1; step 4; see also Rstudio script). Two patches were selected, and the "dissolve" tool was applied to these vector layers to unify adjacent boundaries. This step was crucial for calculating both the number of pixels indicating the presence of *R. okamurae* (coverage) and the average NDVI for the entire study area (entire coastline) and the most extensive areas (each patch) (Figure 1; step 5).

### References
[1] S. Haro, B. Jesus, S. Oiry, S. Papaspyrou, M. Lara, C.J. González, A. Corzo, Sci. Total Environ. 804 (2022) 149983.
[2] L.M. Zoffoli, P. Gernez, P. Rosa, A. Le, V.E. Brando, A. Barillé, N. Harin, S. Peters, K. Poser, L. Spaias, G. Peralta, L. Barillé, Remote Sens. Environ. 251 (2020) 112020.
[3] L. Schreyers, T. van Emmerik, L. Biermann, Y.-F. Le Lay, Remote Sens. 13 (2021) 1408.
[4] S. Haro, R. Bermejo, R. Wilkes, L. Bull, L. Morrison, Int. J. Appl. Earth Obs. Geoinf. 122 (2023) 103451.
[5] S. Haro, J. Jimenez-Reina, R. Bermejo, L. Morrison, SoftwareX 24 (2023) 101520.

