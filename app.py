from __future__ import annotations

import os
import time

import gradio as gr

from src.llm import text_generation

METAPROMPT = (
    "<s>[INST] <<SYS>>"
    "You are a helpful bot. Answer the user's questions. Respect the user. "
    "Do not provide false information. If you do not know the answer, say I don't know."
    "<</SYS>>"
)


def _build_prompt(msg, hist, system):
    if len(hist) > 5:
        hist = hist[-5:]

    if len(hist) == 0:
        return system + f"{msg} [/INST]"

    prompt = system + f"{hist[0][0]} [/INST] {hist[0][1]} </s>"
    for usr_msg, model_msg in hist[1:]:
        prompt += f"<s>[INST] {usr_msg} [/INST] {model_msg} </s>"
    prompt += f"<s>[INST] {msg} [/INST]"
    return prompt


def user(msg, hist):
    return "", hist + [[msg, None]]


def predict(msg, hist, system):
    if system is None or system == "":
        system = METAPROMPT
    prompt = _build_prompt(msg, hist, system)
    hist[-1][1] = ""
    for character in text_generation.generate_text(prompt):
        hist[-1][1] += character
        time.sleep(0.05)
        yield hist


with gr.Blocks() as demo:
    gr.Markdown("# Llama v2 7b Chatbot")
    chatbot = gr.Chatbot(height=400)
    msg = gr.Textbox(label="Prompt", lines=1, placeholder="Type your prompt here:")

    with gr.Accordion(label="Advanced options", open=False):
        system = gr.Textbox(
            label="System",
            lines=2,
            placeholder="Enter system prompt here:",
        )
        temperature = gr.Slider(
            minimum=0,
            maximum=1,
            step=0.1,
            value=0.1,
            label="Temperature",
        )

    btn = gr.Button(label="Submit")
    clear = gr.ClearButton(components=[msg, chatbot], value="Clear console")

    btn.click(user, inputs=[msg, chatbot], outputs=[msg, chatbot], queue=False).then(
        predict,
        inputs=[msg, chatbot, system],
        outputs=chatbot,
    )
    msg.submit(user, inputs=[msg, chatbot], outputs=[msg, chatbot], queue=False).then(
        predict,
        inputs=[msg, chatbot, system],
        outputs=chatbot,
    )
    clear.click(lambda: None, None, chatbot, queue=False)


if __name__ == "__main__":
    demo.queue().launch(
        debug=False,
        width=400,
        server_name="0.0.0.0",
        server_port=int(os.environ.get("PORT", 7860)),
    )
