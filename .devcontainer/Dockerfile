FROM nvidia/cuda:12.2.0-base-ubuntu22.04

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

# Download models
RUN mkdir -p models && \
    cd models && \
    wget https://huggingface.co/TheBloke/Llama-2-7B-Chat-GGML/resolve/main/llama-2-7b-chat.ggmlv3.q4_0.bin

# Copy files
# COPY install_cuda_toolkit.sh .
COPY install_dependencies.sh .
COPY dev-requirements.txt .

# Commented out, using CUDA 12.2.0 Docker image
# Install CUDA Toolkit
# RUN bash ./install_cuda_toolkit.sh

# Install dependencies
RUN bash ./install_dependencies.sh ./dev-requirements.txt && \
    rm ./install_dependencies.sh ./dev-requirements.txt
