#!/bin/bash

# Source: https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&Distribution=WSL-Ubuntu&target_version=2.0&target_type=deb_local

# To check your OS architecture, run:
# lscpu

# Dependency
apt install -y wget

# Install CUDA Toolkit
wget https://developer.download.nvidia.com/compute/cuda/repos/wsl-ubuntu/x86_64/cuda-wsl-ubuntu.pin
mv cuda-wsl-ubuntu.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget https://developer.download.nvidia.com/compute/cuda/12.2.1/local_installers/cuda-repo-wsl-ubuntu-12-2-local_12.2.1-1_amd64.deb
dpkg -i cuda-repo-wsl-ubuntu-12-2-local_12.2.1-1_amd64.deb
cp /var/cuda-repo-wsl-ubuntu-12-2-local/cuda-*-keyring.gpg /usr/share/keyrings/
apt update
apt install -y cuda

# Add CUDA to the PATH
# Append the export commands to ~/.bashrc
echo "export PATH=\"/usr/local/cuda-12.2/bin:$PATH\"" >> ~/.bashrc
echo "export LD_LIBRARY_PATH=\"/usr/local/cuda-12.2/lib64:$LD_LIBRARY_PATH\"" >> ~/.bashrc
source ~/.bashrc
