This repository is a fork of [**DSO**](https://github.com/JakobEngel/dso), incorporating updates to utilize most recent libraries.

This version has been modified to serve as a baseline for Visual Simultaneous Localization and Mapping (VSLAM) experiments within the  [**VSLAM-LAB**](https://github.com/alejandrofontan/VSLAM-LAB) environment. 

# DSO: Direct Sparse Odometry

**Note**: The current version of this repository only supports the radtan distortion model with 5 parameters. As a result, other capabilities such as using photometric calibration might not be working properly.

# Getting Started
If you want to run DSO on your own data that is not contained in  [**VSLAM-LAB**](https://github.com/alejandrofontan/VSLAM-LAB), you can follow these steps.

## Installation
To ensure all dependencies are properly installed, we suggest using *mamba*. If you haven't installed *mamba* yet, please download and set up [`miniforge`](https://github.com/conda-forge/miniforge), which is a more streamlined installer. This installer will create a "base" environment that includes the *conda* and *mamba* package managers.

If you already have a conda installation, you can add mamba by running:
```
conda install mamba -c conda-forge
```
Clone the repository:
```
git clone https://github.com/alejandrofontan/dso.git && cd dso
```
Create the environment:

```
mamba env create -f environment.yml
```
```
mamba activate dso
```
Build DSO:
```
python build.py
```

## Related Publications:
* **Direct Sparse Odometry**, *J. Engel, V. Koltun, D. Cremers*, In arXiv:1607.02565, 2016
* **A Photometrically Calibrated Benchmark For Monocular Visual Odometry**, *J. Engel, V. Usenko, D. Cremers*, In arXiv:1607.02555, 2016

## License
DSO was developed at the Technical University of Munich and Intel.
The open-source version is licensed under the GNU General Public License Version 3 (GPLv3).
See [http://vision.in.tum.de/dso](http://vision.in.tum.de/dso) for details.
