FROM nvidia/cuda:12.2.0-devel-ubuntu22.04

ENV LANG=C.UTF-8

# Grant ROOT access
USER root

# Set working directory
WORKDIR /opt/app

# Copy stable scripts
COPY scripts/install_packages.sh .
COPY scripts/install_python.sh .

# Install packages and dependencies
RUN bash ./install_packages.sh && rm ./install_packages.sh

# Install Python 3.11
RUN ./install_python.sh && rm ./install_python.sh

# Install dependencies
COPY scripts/install_dependencies.sh .
COPY requirements.txt .
RUN bash ./install_dependencies.sh ./requirements.txt && \
    rm ./install_dependencies.sh ./requirements.txt

# Application
# Set PYTHONPATH
ENV PYTHONPATH="${PYTHONPATH}:/opt/app/"

# Copy modules and app.py
ADD src ./src
COPY app.py .

# Download model
COPY scripts/download_model.sh .
RUN bash ./download_model.sh && rm ./download_model.sh

# Expose port
EXPOSE 7860

# Run APP
CMD ["python", "app.py"]
