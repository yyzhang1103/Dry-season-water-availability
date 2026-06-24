# Input Data Format

The MATLAB scripts require processed `.mat` files to reproduce the main figures.

## Required files

The processed input files should include:

- `Figure1.mat`
- `Figure2.mat`
- `figure3.mat`

## Dimensions

Most global map variables are stored on a 1-degree grid.

- lat: 180
- lon: 360

Land-only variables are stored as one-dimensional arrays using `kland_1d`.

## File descriptions

### Figure1.mat

Processed data used by `Figure1.m` to reproduce changes in annual and dry-season water availability.

### Figure2.mat

Processed data used by `Figure2.m` to reproduce changes in evaporation, land-fraction dominance analysis, and regional temperature-response relationships.

### figure3.mat

Processed data used by `Figure3.m` to reproduce changes in evaporative efficiency and soil evaporation factors.


## Missing values

Missing values and non-land pixels should be stored as `NaN`.

## Example shapes

- global map: 180 × 360
- land-only variable: N_land × 1
- yearly land-only variable: N_land × N_years
