#!/bin/bash

mkdir -p /opt/models

cd /opt/models

# 4 bit quantized model
if [ ! -f llama-2-7b-chat.ggmlv3.q4_0.bin ]; then
    wget https://huggingface.co/TheBloke/Llama-2-7B-Chat-GGML/resolve/main/llama-2-7b-chat.ggmlv3.q4_0.bin
fi

# # 8 bit quantized model
# if [ ! -f llama-2-7b-chat.ggmlv3.q8_0.bin ]; then
#     wget https://huggingface.co/TheBloke/Llama-2-7B-Chat-GGML/resolve/main/llama-2-7b-chat.ggmlv3.q8_0.bin
# fi
