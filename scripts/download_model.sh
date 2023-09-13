#!/bin/bash

mkdir -p /opt/models

cd /opt/models

# 4 bit quantized model
if [ ! -f llama-2-7b-chat.ggmlv3.q4_0.bin ]; then
    wget https://huggingface.co/TheBloke/Llama-2-7b-Chat-GGUF/resolve/main/llama-2-7b-chat.Q4_0.gguf
fi
