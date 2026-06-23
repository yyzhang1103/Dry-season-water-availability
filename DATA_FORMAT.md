# Input Data Format

The MATLAB scripts require processed `.mat` files to reproduce the main figures.

## Required files

The processed input files should include:

- `Figure1.mat`
- `Figure2.mat`
- `figure3.mat`
- `kland_1d.mat`
- `dry_knans.mat`

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

### kland_1d.mat

The land mask file should contain:

- `kland_1d`

Non-NaN land-grid variables can be mapped back to the 180 × 360 grid using this index.

### dry_knans.mat

Auxiliary mask information used by the plotting scripts.

## Missing values

Missing values and non-land pixels should be stored as `NaN`.

## Example shapes

- global map: 180 × 360
- land-only variable: N_land × 1
- yearly land-only variable: N_land × N_years
