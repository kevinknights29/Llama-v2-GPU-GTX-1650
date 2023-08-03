#!/bin/bash

# Check if the path to the requirements file was provided
if [ -z "$1" ]; then
    echo "Please provide the path to the requirements file"
    exit 1
fi

# Installing prerequisites
apt-get update && \
    apt-get install -y \
    build-essential \
    python3-launchpadlib \
    python3-dev \
    python3-pip \
    python3-venv \
    gcc \
    && apt update

# Initialize the virtual environment
python3 -m venv .venv

# Activate the virtual environment
source .venv/bin/activate

# Set the path of the requirements.txt file
REQUIREMENTS_FILE=$1

# Set llama.cpp environment variables
export CMAKE_ARGS="-D LLAMA_CUBLAS=ON -D CMAKE_CUDA_COMPILER=$(which nvcc)"
export FORCE_CMAKE=1

# Install the Python packages
pip3 install -r $REQUIREMENTS_FILE
