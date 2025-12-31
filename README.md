## Optimization of Vehicle Suspensions

**OptSusp: Optimization of Vehicle Suspensions** is a Matlab package designed to ...

<p align="center">
<img src="logo/SpringpotTuneFramework.png" width="65%">
</p>

**OptSusp** uses as optimization tool the package **CEopt - Cross-Entropy Optimizer**, which can be downloaded at <a href="https://ceopt.org" target="_blank">https://ceopt.org</a>.

### Table of Contents
- [Overview](#overview)
- [Features](#features)
- [Usage](#usage)
- [Documentation](#documentation)
- [Reproducibility](#reproducibility)
- [Authors](#authors)
- [Citing FracTune](#citing-fractune)
- [License](#license)
- [Institutional support](#institutional-support)
- [Funding](#funding)

### Overview
**OptSusp** was developed to ... The underlying results are reported in the following publication:
- *J. G. Telles Ribeiro and A. Cunha Jr, Scenario-driven optimization of passive vehicle suspensions: explaining the effectiveness of asymmetric damping, 2026 (under review)*

Preprint available here.

### Features
- Implements the Cross-Entropy method for fitting variable-order springpot models
- Transparent "gray-box" optimizer offering intuitive control over key parameters
- Robust and scalable for moderately complex fitting problems in rheological systems
- Demonstrated versatility and effectiveness through case studies of variable-order fractional models

### Usage
To get started with **SpringpotTune**, follow these steps:
1. Clone the repository:
   ```bash
   git clone https://github.com/americocunhajr/SpringpotTune.git
   ```
2. Navigate to the code directory:
   ```bash
   cd SpringpotTune/SpringpotTune-1.0
   ```
3. To calibrate the Springpot model, execute the main file:
   ```bash
   Main_VOSpringpot_Calibration1
   ```

This package includes the following files:
* Main_VOSpringpot_Calibration1.m --- Calibrates the variable-order springpot model parameters (elastic modulus, viscosity, initial & asymptotic fractional orders, characteristic time, deformation rate) to experimental creep data
* Main_VOSpringpot_Calibration2.m --- Performs a second calibration stage using a phenomenological equation to capture the load-dependent behavior of the mechanical properties. This script uses the CEopt black-box package (without exposing the internal CEopt code) and compares the calibrated phenomenological curve against reference values obtained from the first calibration
* Main_VOSpringpot_StrainCurves.m --- Computes and plots the strain evolution curve for a chosen material (PP or PVC) and load using the calibrated variable-order springpot model. The script reads the experimental data from CSV files, automatically discovers the available loads, and then filters the data for the selected load value
* CEopt.m -- Cross-entropy solver
* CreepDataPP.csv: Contains creep test data for polypropylene (PP) with columns for load (MPa), time (days), and strain (%)
CreepDataPVC.csv: Contains creep test data for polyvinyl chloride (PVC) with columns for load (MPa), time (days), and strain (%)
* PlotSemilogx2.m -- Auxiliary function to plot two curves from given datasets in semilogx scale
* PlotLoglog2.m -- Auxiliary function to plot two curves from given datasets in loglog scale
* Plot2.m -- Auxiliary function to plot two curves from given datasets in linear scale

### Documentation
The routines in **OptSusp** are well-commented to explain their functionality. Each routine includes a description of its purpose, inputs, and outputs. 

### Reproducibility

Simulations done with **OptSusp** are fully reproducible, as can be seen on this <a href="https://codeocean.com/capsule/xxx/" target="_blank">CodeOcean capsule</a>.

### Authors
- José Geraldo Telles Ribeiro (UERJ)
- Americo Cunha Jr (LNCC / UERJ)

### Citing OptSusp
We ask the package users to cite the following manuscript in any publications reporting work done with our code or data:
- *J. G. Telles Ribeiro and A. Cunha Jr, Scenario-driven optimization of passive vehicle suspensions: explaining the effectiveness of asymmetric damping, 2026 (under review)*

```
@article{TellesRibeiro2026OptSusp,
   author  = {J. G. {Telles Ribeiro} and A. {Cunha~Jr}},
   title   = "{Scenario-driven optimization of passive vehicle suspensions: explaining the effectiveness of asymmetric damping}",
   journal = {Under Review},
   year    = {2026},
   volume  = {~},
   pages   = {~},
   doi    = {~},
}
```

### License
**OptSusp** is released under the MIT license. See the LICENSE file for details. All new contributions must be made under the MIT license.

<img src="logo/mit_license_red.png" width="10%"> 

### Institutional support

<img src="logo/logo_uerj.png" width="13%"> &nbsp; &nbsp; &nbsp; <img src="logo/logo_lncc.png" width="25%">

### Funding

<img src="logo/cnpq.png" width="20%"> &nbsp; &nbsp; <img src="logo/capes.png" width="10%">  &nbsp; &nbsp; &nbsp; <img src="logo/faperj.png" width="25%">
