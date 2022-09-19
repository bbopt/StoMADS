*****
# StoMADS algorithm for stochastic blackbox optimization
*****
[StoMADS](https://doi.org/10.1007/s10589-020-00249-0) is an extension of the [MADS](https://doi.org/10.1137/040603371) algorithm, and is developed for the optimization of stochastically noisy objective functions, i.e., whose
values can be computed through a blackbox corrupted by some random noise. It is a direct-search algorithm which takes as input a vector
of decision variables. 

## Prerequisites

* StoMADS is implemented using Matlab R2021a.
* To use the 40 problems from the YATSOp repository, email poptus@mcs.anl.gov or see [link](https://github.com/POptUS/YATSOp) if it is available (more details below).

## Installation of StoMADS

No installation is required. Users simply need to download the stomads folder, and use either stomads_applications.m or stomads_experiments.m
to run the algorithm (more details below).

## Getting started

In the stomads folder, users have two options, using either stomads_applications.m or stomads_experiments.m to run StoMADS.

* stomads_applications.m runs StoMADS on unconstrained problems, or problems with bound constraints. It aims to show users how to provide problems to the algorithm.
Other very detailed information is provided in the file.
* stomads_experiments.m runs StoMADS in an automated way on the 40 problems (from the YATSOp repository) considered in the numerical section of the 
[STARS paper](https://arxiv.org/abs/2207.06452), for various types of noise (additive, multiplicative, Gaussian, uniform, etc.), 
and various noise levels via their standard deviations. It generates solutions files, stats files and history files in a 'StoMADS_Output' folder, 
which can be used to generate data profiles, performance profiles, trajectory plots, convergence graphs, etc. Users can therefore refer to the numerical section of 
the [STARS paper](https://arxiv.org/abs/2207.06452) for more details on the use of this script. Other very detailed information is provided in the stomads_experiments.m 
file.

### Regarding the YATSOp repository

* See above about how to access the repository.
* There is another YATSOp folder inside the StoMADS_Main_Files subfolder of stomads, which contains a single Readme.txt file. Information is provided in 
this txt file on how to add the location of the YATSOp folder to the Matlab path.

## Citing StoMADS

If you use StoMADS, please cite the following [paper](https://doi.org/10.1007/s10589-020-00249-0).


```

@article{AuDzKoDi2021,
	Author   = {C. Audet and K.J. Dzahini and M. Kokkolaras and S. {Le~Digabel}},
	Title    = {Stochastic mesh adaptive direct search for blackbox optimization using probabilistic estimates},
	Journal  = {Computational Optimization and Applications},
	Year     = {2021},
	Volume  = {79},
	Number  = {1},
	Pages   = {1--34},
	Doi = {10.1007/s10589-020-00249-0},
	Url      = {https://doi.org/10.1007/s10589-020-00249-0}
}



```
[![DOI](https://doi.org/10.1007/s10589-020-00249-0)](https://doi.org/10.1007/s10589-020-00249-0)
