from __future__ import annotations

import os

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


def predict(msg, hist, system):
    if system is None or system == "":
        system = METAPROMPT
    prompt = _build_prompt(msg, hist, system)
    return text_generation.generate_text(prompt)


with gr.Blocks("Llama v2 7b Chatbot") as demo:
    chatbot = gr.Chatbot(height=400, width=400)
    msg = gr.Textbox(label="Prompt", lines=2, placeholder="Type your prompt here:")

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
            default=0.1,
            label="Temperature",
        )

    btn = gr.Button(label="Submit")
    clear = gr.ClearButton(components=[msg, chatbot], value="Clear console")

    btn.click(predict, inputs=[msg, chatbot, system], outputs=[msg, chatbot])
    msg.submit(predict, inputs=[msg, chatbot, system], outputs=[msg, chatbot])

if __name__ == "__main__":
    demo.queue().launch(debug=True, server_port=int(os.environ.get("PORT", 7860)))
