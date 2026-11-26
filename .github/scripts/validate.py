#!/usr/bin/env python3
"""Validate the KillerCoda tutorials of the repository.

Usage: validate.py            validate the whole repository
       validate.py --changed REF  validate only the tutorials changed since REF

Checks:
  * every structure.json / index.json is valid JSON
  * every path listed in a structure.json exists and has its own structure.json or index.json
  * every file referenced by an index.json exists (steps, scripts, assets)
  * every Taskfile.yaml is valid YAML, is accepted by `task --list`,
    and each of its shell commands passes `bash -n`
  * every shell script passes `bash -n`
"""
import json
import re
import subprocess
import sys
from pathlib import Path

import yaml

ROOT = Path(__file__).resolve().parents[2]
errors = []


def error(path, message):
    errors.append(f"{path.relative_to(ROOT)}: {message}")


def load_json(path):
    try:
        return json.loads(path.read_text())
    except (ValueError, OSError) as e:
        error(path, f"invalid JSON: {e}")
        return None


def tracked(pattern):
    out = subprocess.run(["git", "ls-files", pattern], cwd=ROOT, capture_output=True, text=True, check=True).stdout
    return [ROOT / line for line in out.splitlines()]


def check_structure(path):
    data = load_json(path)
    for item in (data or {}).get("items", []):
        target = path.parent / item.get("path", "")
        if not target.is_dir():
            error(path, f"item path '{item.get('path')}' is not a directory")
        elif not ((target / "structure.json").exists() or (target / "index.json").exists()):
            error(path, f"item '{item.get('path')}' has neither structure.json nor index.json")


FILE_KEYS = {"text", "foreground", "background", "verify", "setup"}


def referenced_files(node):
    """Yield the tutorial-relative files of intro, steps and finish entries."""
    if isinstance(node, dict):
        for key, value in node.items():
            if key == "assets":
                continue
            if key in FILE_KEYS and isinstance(value, str):
                yield value
            else:
                yield from referenced_files(value)
    elif isinstance(node, list):
        for value in node:
            yield from referenced_files(value)


def check_index(path):
    data = load_json(path)
    if not data:
        return
    details = data.get("details", {})
    for ref in referenced_files(details):
        if not (path.parent / ref).is_file():
            error(path, f"missing file '{ref}'")
    for host, files in details.get("assets", {}).items():
        for entry in files:
            ref = entry.get("file", "")
            if not (path.parent / "assets" / ref).exists():
                error(path, f"missing asset '{ref}' for {host}")


def render(command):
    """Replace Task templates by a placeholder so the command can be parsed by bash."""
    return re.sub(r"\{\{.*?\}\}", "X", command)


def check_taskfile(path):
    try:
        data = yaml.safe_load(path.read_text())
    except yaml.YAMLError as e:
        error(path, f"invalid YAML: {e}")
        return
    result = subprocess.run(["task", "--taskfile", str(path), "--list-all"], capture_output=True, text=True)
    if result.returncode:
        error(path, f"task rejected the file: {result.stderr.strip()}")
    for name, spec in (data.get("tasks") or {}).items():
        for command in (spec or {}).get("cmds", []) or []:
            if isinstance(command, str):
                bash = subprocess.run(["bash", "-n"], input=render(command), text=True, capture_output=True)
                if bash.returncode:
                    error(path, f"task '{name}': {bash.stderr.strip()}")


def check_shell(path):
    bash = subprocess.run(["bash", "-n", str(path)], capture_output=True, text=True)
    if bash.returncode:
        error(path, bash.stderr.strip())


def changed_files(base):
    out = subprocess.run(["git", "diff", "--name-only", "--diff-filter=d", f"{base}...HEAD"],
                         cwd=ROOT, capture_output=True, text=True, check=True).stdout
    return [ROOT / line for line in out.splitlines()]


def main():
    structures = tracked("**/structure.json") + tracked("structure.json")
    indexes = tracked("**/index.json")
    taskfiles = tracked("**/Taskfile.yaml")
    scripts = tracked("**/*.sh")
    if len(sys.argv) == 3 and sys.argv[1] == "--changed":
        # Pull request mode: only validate what the pull request touches
        changed = changed_files(sys.argv[2])
        # A change to the pipeline itself validates every tutorial
        pipeline = any(ROOT / ".github" in c.parents for c in changed)
        tutorials = [i.parent for i in indexes if pipeline or any(i.parent in c.parents for c in changed)]
        inside = lambda path: any(t in path.parents for t in tutorials)
        structures = [s for s in structures if pipeline or s in changed]
        indexes = [i for i in indexes if i.parent in tutorials]
        taskfiles = [t for t in taskfiles if inside(t)]
        scripts = [s for s in scripts if inside(s)]
        print(f"Validating {len(tutorials)} tutorial(s) and {len(structures)} structure file(s)")
    for path in structures:
        check_structure(path)
    for path in indexes:
        check_index(path)
    for path in taskfiles:
        check_taskfile(path)
    for path in scripts:
        check_shell(path)
    for message in sorted(set(errors)):
        print(f"::error::{message}")
    print(f"{len(set(errors))} problem(s) found")
    return 1 if errors else 0


if __name__ == "__main__":
    sys.exit(main())
