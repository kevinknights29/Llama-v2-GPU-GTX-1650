#!/bin/bash

# Download Python 3.11 source code
wget https://www.python.org/ftp/python/3.11.0/Python-3.11.0.tgz

# Extract the downloaded file
tar -xvf Python-3.11.0.tgz

# Build Python from source
cd Python-3.11.0
./configure --enable-optimizations && \
    make altinstall

# Remove unnecessary files
cd ..
rm -rf Python-3.11.0.tgz Python-3.11.0

# Make Python 3.11 as the default Python version
update-alternatives --install /usr/bin/python python /usr/local/bin/python3.11 1

# Install pip
apt-get update && \
    apt-get install -y --no-install-recommends \
    python3-pip
