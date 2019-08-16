# sage-notebook [![Build Status](https://travis-ci.org/sharpTrick/sage-notebook.svg?branch=master)](https://travis-ci.org/sharpTrick/sage-notebook)
sage-notebook is a community maintained Jupyter Docker Stack image with the sagemath kernel.

Like jupyter packages in the base image, the sagemath environment is installed via conda from conda-forge as per http://doc.sagemath.org/html/en/installation/conda.html and the sagemath kernel is executed in this environment by invoking [`conda run -n sage ...`](https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html?highlight=%22conda%20run%22#activating-an-environment).

Development of conda sage packages appears to be tracked at https://wiki.sagemath.org/Conda

# Launch on binder
Try this Jupyter Notebook online with this link. No installation is needed.
[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/sharpTrick/sage-notebook/master)

# Docker Hub
* Docker Hub [hub.docker.com/r/sharptrick/sage-notebook](https://hub.docker.com/r/sharptrick/sage-notebook)

Docker Pull Command for Docker image with **sagemath Kernel** installed.
```
docker pull sharptrick/sage-notebook
```

# GitHub
* GitHub [github.com/sharpTrick/sage-notebook](https://github.com/sharpTrick/sage-notebook)

# References
## sagemath kernel
This Dockerfile is made possible by the work of https://sagemath.org/

## Jupyter Docker Stacks - Community Stack version
This project is developed with the helpful guide of [Jupyter Docker Stacks](https://jupyter-docker-stacks.readthedocs.io/en/latest/). The base container is **jupyter/minimal-notebook** and this **Community Stack** is setup [via the guide.](https://jupyter-docker-stacks.readthedocs.io/en/latest/contributing/stacks.html)
