from __future__ import annotations

import os
from pathlib import Path


def find_model(
    model_dir=os.environ.get("MODEL_DIR", "/opt/app/models"),
    pattern="*.bin",
):
    model_path = Path(model_dir)
    model_file_path = list(model_path.glob(pattern))[0]
    return str(model_file_path.resolve())
