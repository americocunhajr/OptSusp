## Optimization of Vehicle Suspensions

**OptSusp: Optimization of Vehicle Suspensions** is a Matlab package designed to benchmark and optimize passive quarter-car suspensions under standardized stochastic and transient road excitations, combining ISO-based performance metrics with Cross-Entropy global optimization to reveal when asymmetric damping becomes an optimal, scenario-dependent design choice.

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
- [Citing OptSusp](#citing-optsusp)
- [License](#license)
- [Institutional support](#institutional-support)
- [Funding](#funding)

### Overview
**OptSusp** was developed to provide a flexible, reproducible MATLAB framework for simulating and optimizing passive vehicle suspension systems, with a particular focus on asymmetric damping, ride comfort, road holding, and transient performance under realistic driving scenarios. The underlying results are reported in the following publication:
- *J. G. Telles Ribeiro and A. Cunha Jr, Scenario-driven optimization of passive vehicle suspensions: explaining the effectiveness of asymmetric damping, 2026 (under review)*

Preprint available here.

### Features
- Implements the Cross-Entropy (CE) method for the optimization of passive vehicle suspension parameters
- Supports asymmetric damping configurations with independent rebound and compression tuning
- Scenario-driven framework combining stochastic road excitation and transient analysis
- Simulation-based, gray-box optimization with intuitive and physically meaningful control parameters
- Robust to non-convex, non-smooth objective functions arising from nonlinear vehicle dynamics
- Modular MATLAB implementation built around a quarter-car model, facilitating extension and reuse
- Designed for systematic exploration of comfort–safety–transient trade-offs in suspension design

### Usage
To get started with **SpringpotTune**, follow these steps:
1. Clone the repository:
   ```bash
   git clone https://github.com/americocunhajr/OptSusp.git
   ```
2. Navigate to the code directory:
   ```bash
   cd OptSusp/OptSusp-1.0
   ```
3. To optimize the car suspension, execute the main file:
   ```bash
   MainCarSuspensionAssymDesign_CE
   ```

This package includes the following files:
* MainCarSuspensionAssymDesign_CE.m - Main script that performs scenario-driven optimization of passive vehicle suspensions with asymmetric damping using the Cross-Entropy method. Defines operating scenarios (road class, speed, vehicle mass), optimization settings, and calls the objective function and dynamic simulations.
* MainCarSuspensionDynamics.m - Runs time-domain simulations of the quarter-car model under stochastic (ISO 8608) and deterministic (step and bump) road excitations. Computes sprung-mass acceleration, tire–ground contact force, and transient response metrics.
* QuarterCarModel.m - Implements the nonlinear quarter-car model with asymmetric damping and unilateral tire contact.
* ObjFunc.m - Defines the scalar objective function used in optimization, combining weighted RMS acceleration, tire–ground contact force variability, and reference targets for scenario-driven trade-off analysis.
* isoWdFilter.m - Generates stochastic road profiles based on ISO 8608 spatial power spectral density classes. Converts spatial profiles into time signals according to vehicle speed.
* TanhStep.m - Smooth step function based on hyperbolic tangent, used to regularize discontinuities in transient road inputs (step and bump profiles).
* dTanhStep.m - Derivative of the smooth step value function, provided for completeness and post-processing consistency.
* SoftPlus.m - Numerically stable SoftPlus function used as a smooth approximation of $\max(0,x)$ for regularizing unilateral tire contact and non-smooth nonlinearities.
* dSoftPlus.m - Derivative of the stable SoftPlus function, provided for completeness and post-processing consistency.
* SmoothAbs.m - Smooth approximation of the absolute value function, used to regularize non-smooth objective-function components.
* dSmoothAbs.m - Derivative of the smooth absolute value function, provided for completeness and post-processing consistency.
* CEopt.m -- Cross-entropy solver

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
