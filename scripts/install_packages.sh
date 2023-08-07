#!/bin/bash

# Install packages and dependencies
apt update && \
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
    libbz2-dev \
    python3-launchpadlib \
    python3-dev \
    python3-pip \
    python3-venv \
    gcc
