ARG BASE_CONTAINER=jupyter/minimal-notebook
FROM $BASE_CONTAINER

USER root

# Sage pre-requisites and jq for manipulating json
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    dvipng \
    ffmpeg \
    imagemagick \
    texlive \
    tk tk-dev \
    jq && \
    rm -rf /var/lib/apt/lists/*


USER $NB_UID

# Install Sage conda environment
RUN conda create --quiet --yes --name sage \
    sage python=2.7 --channel conda-forge && \
    conda clean --all -f -y && \
    npm cache clean --force && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

# Install sagemath kernel and extensions using conda run:
#   Create jupyter directories if they are missing
#   Add "conda run -n sage" to sage kernal using jq
#   Symbolically link all available kernels and extensions
#     but ignore errors caused by pre-existent kernel or extension conflicts
RUN mkdir -p $CONDA_DIR/share/jupyter/kernels/sagemath && \
    mkdir -p $CONDA_DIR/share/jupyter/nbextensions && \
    echo ' \
        ln -s $SAGE_LOCAL/share/jupyter/kernels/sagemath/*  $CONDA_DIR/share/jupyter/kernels/sagemath/ && \
        rm $CONDA_DIR/share/jupyter/kernels/sagemath/kernel.json && \
        cat $SAGE_LOCAL/share/jupyter/kernels/sagemath/kernel.json | \
        jq '"'"'.argv=[env.CONDA_DIR+"/bin/conda", "run", "-n", "sage"] + .argv '"'"' > \
        $CONDA_DIR/share/jupyter/kernels/sagemath/kernel.json && \
        sh -c "ln -s $SAGE_LOCAL/share/jupyter/kernels/*/ $CONDA_DIR/share/jupyter/kernels/ ; exit 0" && \
        sh -c "ln -s $SAGE_LOCAL/share/jupyter/nbextensions/*/ $CONDA_DIR/share/jupyter/nbextensions/ ; exit 0" \
    ' | conda run -n sage sh && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

