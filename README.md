# Llama-v2-GPU-GTX-1650

Running Llama v2 with Llama.cpp in a 4GB VRAM GTX 1650.

## Setup

To extend your Nvidia GPU resource and drivers to a docker container.

You need to install [NVIDA CUDA Container Toolkit](https://github.com/NVIDIA/nvidia-container-toolkit)

## Results

### Llama.cpp recognizing cuBLAS optimizer

![image](https://github.com/kevinknights29/Llama-v2-GPU-GTX-1650/assets/74464814/d9a0a31c-1f11-48af-a12a-6ebf39dad33d)

### After optimizing values for inference

```bash
N_GPU_LAYERS=35
N_BATCH=4096
N_THREADS=4
```

![image](https://github.com/kevinknights29/Llama-v2-GPU-GTX-1650/assets/74464814/2ae60757-feef-433c-b1c0-65c24bcf21cc)

### Streaming support

https://github.com/kevinknights29/Llama-v2-GPU-GTX-1650/assets/74464814/af8d771a-a750-4361-a7f4-ca646087a087

## Usage

### Build APP Image

```bash
docker compose build
```

### Get everything up and running

```bash
docker compose down && docker compose up -d
```

### Have fun

Visit: `http://localhost:7861/` to access the Gradio Chatbot UI.

## Contributing

### Installing pre-commit

Pre-commit is already part of this project dependencies.
If you would like to installed it as standalone run:

```bash
pip install pre-commit
```

To activate pre-commit run the following commands:

- Install Git hooks:

```bash
pre-commit install
```

- Update current hooks:

```bash
pre-commit autoupdate
```

To test your installation of pre-commit run:

```bash
pre-commit run --all-files
```
