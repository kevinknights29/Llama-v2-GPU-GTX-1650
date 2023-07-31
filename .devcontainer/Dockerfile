FROM python:3.11.4-slim-bullseye

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

# Install dependencies
RUN bash ./install_dependencies.sh ./dev-requirements.txt
