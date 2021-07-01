#!/bin/bash
set -e  # exit when any command fails

mkdir -p "$CONDA_PREFIX"/etc/conda/activate.d
echo "#!/bin/sh" >> "$CONDA_PREFIX"/etc/conda/activate.d/env_vars.sh

# in pumapy env we only add PuMA_DIR
if [ "$(uname)" == "Darwin" ]; then
    s=${BASH_SOURCE[0]} ; s=`dirname $s` ; PuMA_DIR=`cd $s/../.. ; pwd`
    PuMA_OS="Mac"

elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    PuMA_DIR="$(echo "$( dirname "$( dirname "$( dirname "$(readlink -f -- "${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}")")")")")"
    PuMA_OS="Linux"
else
    echo "Unrecongnized Operating System, PuMA cannot be installed."
    exit 1
fi

if [ $CONDA_DEFAULT_ENV == "puma" ]; then
    if [ "$(uname)" == "Darwin" ]; then
        echo "export DYLD_FALLBACK_LIBRARY_PATH='$CONDA_PREFIX/lib':'$PuMA_DIR/install/lib':\$DYLD_FALLBACK_LIBRARY_PATH" >> "$CONDA_PREFIX"/etc/conda/activate.d/env_vars.sh

    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
        echo "export LD_LIBRARY_PATH='$CONDA_PREFIX/lib':'$PuMA_DIR/install/lib':\$LD_LIBRARY_PATH" >> "$CONDA_PREFIX"/etc/conda/activate.d/env_vars.sh

        # create libGL for the GUI
        FILE="$CONDA_PREFIX"/x86_64-conda_cos6-linux-gnu/sysroot/usr/lib64/libGL.so.1
        if [ -f "$FILE" ]; then
            cp -r "$CONDA_PREFIX"/x86_64-conda_cos6-linux-gnu/sysroot/usr/lib64 "$CONDA_PREFIX"/x86_64-conda-linux-gnu/sysroot/usr
            cp "$CONDA_PREFIX"/x86_64-conda_cos6-linux-gnu/sysroot/usr/lib64/libGL.so.1 "$CONDA_PREFIX"/x86_64-conda-linux-gnu/sysroot/usr/lib64/libGL.so
        fi
    fi
    echo "export PuMA_OS=$PuMA_OS" >> "$CONDA_PREFIX"/etc/conda/activate.d/env_vars.sh
    echo "export PuMA_DIR='$PuMA_DIR'" >> "$CONDA_PREFIX"/etc/conda/activate.d/env_vars.sh
    echo "export PATH='$PuMA_DIR/install/bin':\$PATH" >> "$CONDA_PREFIX"/etc/conda/activate.d/env_vars.sh
fi

echo "Added variables to conda environment."
