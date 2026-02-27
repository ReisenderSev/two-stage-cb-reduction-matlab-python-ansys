# Two-Stage Craig-Bampton Reduction (MATLAB + Python + ANSYS)

## Overview
This repository contains a two-stage Craig-Bampton (CB) model reduction framework developed for a large-scale ultrasonic system.

The objective of this work is to provide an efficient reduction method for complex ultrasonic structures with high numbers of degrees of freedom (DOFs), while maintaining acceptable accuracy.

## Methodology

The reduction is performed sequentially in two stages:

### Stage 1 – Reduction of the Main Structure
The large plate structure excited by the ultrasonic device is decomposed into substructures and reduced using fixed-interface (Craig-Bampton) reduction.

### Stage 2 – Reduction of the Ultrasonic Device
The ultrasonic device is further decomposed into:
- Transducer  
- Adaptor  

In this stage, the already reduced main structure is treated as an additional substructure and participates in the global reduction process.

This stepwise approach enables reuse of the reduced main structure for design variations of the ultrasonic device (e.g., changes in transducer or adaptor), significantly reducing computational cost for iterative design studies.

## Implementation

- The ultrasonic model is created in CAD software (not included in this repository).
- Python scripts are coupled with ANSYS FEM analyses for automated matrix extraction and preprocessing.
- MATLAB scripts are used for:
  - Craig-Bampton reduction
  - Eigenvector comparison using the Modal Assurance Criterion (MAC)

The repository contains two main components:
1. Vector comparison using Modal Assurance Criterion (MAC)
2. Craig-Bampton reduction framework

## Results

- Eigenfrequencies match the unreduced reference model  
- Significant reduction of DOFs  
- Improved computational efficiency  
