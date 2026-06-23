
This repository contains Matlab codes to reproduce the main figures of the paper “Non-biological evaporation dominates future intensification of global dry-season water scarcity”. 

## Authors

Yangyang Zhang, Dashan Wang, Lan Wang-Erlandsson, Shao Wei, Lingna Wei, Man Gao, and Jianzhi Dong*

## Requirements

All analyses were conducted in MATLAB R2024a.

Required MATLAB toolboxes and external packages:

- MATLAB R2024a
- M_Map toolbox
- slanCM colormap package
- freezeColors
- Custom functions included in this repository, such as `cal_sig.m`

## Repository structure

- `code/Figure/Figure1.m`: reproduces Figure 1
- `code/Figure/Figure2.m`: reproduces Figure 2
- `code/Figure/Figure3.m`: reproduces Figure 3
- `code/code_for_analyzing_factors_affecting_soil_evaporation.m`: analyzes factors affecting soil evaporation
- `code/functions/`: custom helper functions
- `DATA_FORMAT.md`: expected input data format

## Data availability

The scripts require processed CMIP6 and observational data in MATLAB `.mat` format.

Due to file size and/or redistribution restrictions, input data are not included in this repository. Original data are available from their original providers, including CMIP6 and FLUXNET. Processed data will be made available upon reasonable request or deposited in a public repository upon publication.

The expected input file structure is described in `DATA_FORMAT.md`.

## How to run

1. Download or prepare the required input data.
2. Place the processed `.mat` files according to `DATA_FORMAT.md`.
3. Add the `code/Figure/` and `code/functions/` folders to the MATLAB path.
4. Run in MATLAB R2024a.


## Reference
Zhang Y.Y., Wang D.S., Wang-Erlandsson L., Shao W., Wei L.N., Gao M., Dong J.Z., Non-biological evaporation dominates future intensification of global dry-season water scarcity (2026)


