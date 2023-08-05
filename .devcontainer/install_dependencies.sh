#!/bin/bash

# Check if the path to the requirements file was provided
if [ -z "$1" ]; then
    echo "Please provide the path to the requirements file"
    exit 1
fi

# Installing prerequisites
apt update && \
    apt install -y \
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

# Install the Python packages
pip3 install -r $REQUIREMENTS_FILE

# Set llama.cpp environment variables
export LLAMA_CUBLAS=1
# Install llama.cpp
CMAKE_ARGS="-DLLAMA_CUBLAS=on" FORCE_CMAKE=1 pip install --ignore-installed --force-reinstall --upgrade --no-cache-dir llama-cpp-python
