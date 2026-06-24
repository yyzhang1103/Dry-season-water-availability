### original data
The Fluxnet2015 dataset is publicly available at https://fluxnet.org/ data/fluxnet2015-dataset/, the GLASS LAI product (Version 6, MODIS 0.01°, 2000–2024) is publicly available at https://glass.hku.hk/download.html, and the CMIP6 model simulations are publicly available at https://esgf-node.llnl.gov/search/cmip6/.

All CMIP6 variables were first bilinearly interpolated onto a common 1° × 1° global grid. Monthly precipitation, evapotranspiration components, energy fluxes, LAI, surface soil moisture and air temperature were processed for the historical period 1995–2014 and future projections from 2015 to 2100 under SSP2-4.5 and SSP5-8.5. Total evapotranspiration was calculated as the sum of transpiration, soil evaporation and canopy interception evaporation. Annual water availability was calculated as the annual mean P−ET, whereas dry-season water availability was defined for each grid cell and year as the minimum monthly P−ET. Future changes were quantified as differences between the late-century period 2081–2100 and the historical baseline 1995–2014.


## Missing values

Missing values and non-land pixels should be stored as `NaN`.

# Input Data Format

The MATLAB scripts require processed `.mat` files to reproduce the main figures.

## Required files

The processed input files should include:

- `Figure1.mat`
- `Figure2.mat`
- `figure3.mat`

## File descriptions

### Figure1.mat

Processed data used by `Figure1.m` to reproduce changes in annual and dry-season water availability.

### Figure2.mat

Processed data used by `Figure2.m` to reproduce changes in evaporation, land-fraction dominance analysis, and regional temperature-response relationships.

### figure3.mat

Processed data used by `Figure3.m` to reproduce changes in evaporative efficiency and soil evaporation factors.

