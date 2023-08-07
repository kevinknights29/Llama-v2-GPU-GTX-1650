#!/bin/bash

# Check if the path to the requirements file was provided
if [ -z "$1" ]; then
    echo "Please provide the path to the requirements file"
    exit 1
fi

# Set the path of the requirements.txt file
REQUIREMENTS_FILE=$1

# Install the Python packages
python -m pip install -r $REQUIREMENTS_FILE

# Set llama.cpp environment variables
export LLAMA_CUBLAS=1
# Install llama.cpp
CMAKE_ARGS="-DLLAMA_CUBLAS=on" FORCE_CMAKE=1 python -m pip install llama-cpp-python
