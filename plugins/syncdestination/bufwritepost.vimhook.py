#!/usr/bin/env python3
"""
Syncs odoo projects to destination - looks for file
.syncdestination in root
"""
# vimhook.bufferoutput = 0
# vimhook.bufferoutput.vsplit = false
# vimhook.async = true
import sys
import os
import datetime
import subprocess
from pathlib import Path

CONFIG_FILE = '.syncdestination'
MAX_AGE = 30 # minutes

options = [
    "-arP",
    "--links",
    "--exclude=.git",
    "--exclude=.venv",
    "--exclude=odoo.ast",
    "--exclude=*.pyc",
    "--exclude=__pycache__",
    "--delete-after",
    "--delete-excluded",  # https://serverfault.com/questions/573392/rsync-cannot-delete-non-empty-directory-errors-even-with-force-option would also need: --filter='protect .git/' - but we delete
    "--filter=protect .git/",
]

file_path = None
if len(sys.argv) > 1:
    file_path = Path(os.getcwd()) / sys.argv[1]

def deactivate_file(file):
    lines = file.read_text().split("\n")
    lines2 = []
    for line in lines:
        if line and not line.startswith("#"):
            line = "#" + line
        lines2.append(line)
    file.write_text('\n'.join(lines2))

def _get_source_path(file_path):
    p = file_path or Path(os.getcwd())
    while p != Path("/"):
        if (p / CONFIG_FILE).exists():
            stat = (p / CONFIG_FILE).stat()
            diff_seconds = (datetime.datetime.now() - datetime.datetime.fromtimestamp(stat.st_mtime)).total_seconds()
            if diff_seconds / 60.0 > MAX_AGE:
                # deactivate all
                datetime.datetime.fromtimestamp((p / CONFIG_FILE).stat().st_mtime)
                deactivate_file(p / CONFIG_FILE)
                sys.exit(0)

            rel_path = Path('.')
            if file_path and (not file_path.is_dir() or file_path.is_symlink()):
                file_path = file_path.parent
                rel_path = file_path.relative_to(p)

            for line in (p / CONFIG_FILE).read_text().split("\n"):
                while line.endswith("/"):
                    line = line[:-1]
                if line.strip().startswith("#"): continue
                if not line: continue
                # example content: itebox:f/sunday
                assert not str(rel_path).startswith("/") or str(rel_path).startswith("/tmp"), 'rel path may not start with /'
                return line, p, rel_path
        p = p.parent if p else None


remote_path, local_path, rel_path = _get_source_path(file_path)

# fetch updated translations
cmd = [
    "rsync",
    remote_path + "/",
    str(local_path) + "/",
    '-r',
    '--update',
    '--include=*/',
    '--include=**/*.po',
    '--exclude=*',
    "--filter=protect .git/",
]
p1 = subprocess.Popen(cmd)
p1.wait()
del p1

cmd = [
    "rsync",
    str(local_path / rel_path) + "/",
    remote_path + "/" + str(rel_path) + "/"
] + options
p1 = subprocess.call(cmd)
cmd = [
    "rsync",
    str(local_path) + "/",
    remote_path + "/"
] + options
p2 = subprocess.call(cmd)
