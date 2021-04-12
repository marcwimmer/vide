#!/usr/bin/env python3
from pathlib import Path
import sys
import os

collected = {}

for file in Path(os.getcwd()).glob("*.snippets"):
    if '_' not in file.name:
        continue
    base = file.name.split("_")[0]
    collected.setdefault(base, [])
    collected[base].append(file)

for base, paths in collected.items():
    content = ""
    for file in paths:
        content += file.read_text() + '\n'
    file = Path(os.getcwd()) / f"{base}.snippets"
    file.write_text(content)

# use https://github.com/erietz/ultisnips-vscode to convert to vscode
os.system("ultisnips_to_vscode")