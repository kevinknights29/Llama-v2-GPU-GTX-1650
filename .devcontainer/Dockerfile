FROM nvidia/cuda:12.2.0-devel-ubuntu22.04

ENV LANG=C.UTF-8

# Grant ROOT access
USER root

# Install packages and dependencies
RUN apt update && \
    apt install -y --no-install-recommends \
    wget \
    git \
    ca-certificates \
    build-essential \
    zlib1g-dev \
    libncurses5-dev \
    libgdbm-dev \
    libnss3-dev \
    libssl-dev \
    libreadline-dev \
    libffi-dev \
    libsqlite3-dev \
    libbz2-dev

# Install Python 3.11
COPY install_python.sh /opt/
RUN bash /opt/install_python.sh && rm /opt/install_python.sh

# Set working directory
WORKDIR /opt/app

# Copy files
COPY download_model.sh .
COPY install_dependencies.sh .
COPY dev-requirements.txt .

# Commented out, using CUDA 12.2.0 Docker image
# Install CUDA Toolkit
# COPY install_cuda_toolkit.sh .
# RUN bash ./install_cuda_toolkit.sh && \
#     rm ./install_cuda_toolkit.sh

# Install dependencies
RUN bash ./install_dependencies.sh ./dev-requirements.txt && \
    rm ./install_dependencies.sh ./dev-requirements.txt

# Download model
# RUN bash ./download_model.sh && \
#     rm ./download_model.sh
# For better efficiency download model locally
#   and copy it to /opt/models/
