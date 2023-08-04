FROM nvidia/cuda:12.2.0-base-ubuntu22.04

ENV LANG=C.UTF-8

# Set working directory
WORKDIR /opt/app

# Install packages
RUN apt update && \
    apt install -y --no-install-recommends \
    wget \
    git

# Download models
RUN mkdir -p models && \
    cd models && \
    wget https://huggingface.co/TheBloke/Llama-2-7B-Chat-GGML/resolve/main/llama-2-7b-chat.ggmlv3.q4_0.bin

# Copy files
COPY install_dependencies.sh .
COPY dev-requirements.txt .
# COPY install_cuda_toolkit.sh .

# Grant ROOT access
USER root

# Commented out, using CUDA 12.2.0 Docker image
# Install CUDA Toolkit
# RUN bash ./install_cuda_toolkit.sh

# Install Python 3.11
# Install dependencies for building Python
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
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

# Download Python 3.11
WORKDIR /opt
RUN wget https://www.python.org/ftp/python/3.11.0/Python-3.11.0.tgz && \
    tar -xvf Python-3.11.0.tgz

# Build Python from source
WORKDIR /opt/Python-3.11.0
RUN ./configure --enable-optimizations && \
    make altinstall

# Remove unnecessary files
WORKDIR /opt
RUN rm -rf Python-3.11.0.tgz Python-3.11.0

# Make Python 3.11 as the default Python version
RUN update-alternatives --install /usr/bin/python python /usr/local/bin/python3.11 1

# Install pip
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python3-pip

# Go back to your app directory
WORKDIR /opt/app

# Install dependencies
RUN bash ./install_dependencies.sh ./dev-requirements.txt
