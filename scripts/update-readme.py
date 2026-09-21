#!/usr/bin/env python3
"""Regenerate the auto-generated sections of README.md from the actual repo state.

Each section lives between a pair of HTML comment markers:
  <!-- readme-gen:<name>:start -->
  <!-- readme-gen:<name>:end -->

Everything outside those markers (the hand-written narrative) is left alone.
Run directly, or via the .githooks/pre-commit hook.
"""

import json
import subprocess
import sys
from pathlib import Path

ROOT = Path(
    subprocess.run(
        ["git", "rev-parse", "--show-toplevel"], capture_output=True, text=True, check=True
    ).stdout.strip()
)
README = ROOT / "README.md"

EXCLUDE_DIRS = {".git", "pictures"}


def render_inputs() -> str:
    meta = json.loads(
        subprocess.run(
            ["nix", "flake", "metadata", "--json"], capture_output=True, text=True, check=True
        ).stdout
    )
    nodes = meta["locks"]["nodes"]
    root_id = meta["locks"]["root"]
    root_inputs = nodes[root_id]["inputs"]

    rows = []
    for name in sorted(root_inputs):
        target = root_inputs[name]
        # A direct input is a plain node-id string; a `follows` chain is a list.
        # flake.nix only declares direct inputs at the top level, so this is always a string.
        if isinstance(target, list):
            continue
        node = nodes[target]
        original = node.get("original", {})
        locked = node.get("locked", {})

        if original.get("type") == "github":
            source = f"github:{original['owner']}/{original['repo']}"
            pin = original.get("ref") or original.get("rev") or "default branch"
            rev = locked.get("rev", "")[:7]
            pinned = f"{pin} @ {rev}" if rev else pin
        elif original.get("type") == "path":
            source = f"local path (`{original['path']}`)"
            pinned = "-"
        else:
            source = f"{original.get('type', '?')}:{original.get('id', '?')}"
            pinned = locked.get("rev", "-")[:7] or "-"

        rows.append((name, source, pinned))

    lines = ["| Input | Source | Pinned |", "| --- | --- | --- |"]
    lines += [f"| {n} | {s} | {p} |" for n, s, p in rows]
    return "\n".join(lines)


def render_structure() -> str:
    def walk(path: Path, prefix: str = "") -> list[str]:
        entries = sorted(
            (p for p in path.iterdir() if p.name not in EXCLUDE_DIRS and not p.name.startswith(".")),
            key=lambda p: (p.is_file(), p.name),
        )
        lines = []
        for i, entry in enumerate(entries):
            last = i == len(entries) - 1
            connector = "└── " if last else "├── "
            suffix = "/" if entry.is_dir() else ""
            lines.append(f"{prefix}{connector}{entry.name}{suffix}")
            if entry.is_dir():
                extension = "    " if last else "│   "
                lines.extend(walk(entry, prefix + extension))
        return lines

    lines = ["```", "dotfiles/"] + walk(ROOT) + ["```"]
    return "\n".join(lines)


def render_hosts() -> str:
    hosts_dir = ROOT / "modules" / "hosts"
    lines = []
    for host in sorted(p for p in hosts_dir.iterdir() if p.is_dir()):
        has_hw = any(host.glob("*hardware*"))
        detail = "with a dedicated hardware profile" if has_hw else "no hardware profile committed"
        lines.append(f"- **{host.name}** ({detail})")
    return "\n".join(lines)


HM_PLUMBING = {
    "hm-session-vars.sh",
    "home-configuration-reference-manpage",
    "dummy-xdg-mime-dirs1",
    "dummy-xdg-mime-dirs2",
    "man-db",
}


def render_packages() -> str:
    expr = (
        "pkgs: builtins.concatStringsSep \"\\n\" "
        '(map (p: p.pname or p.name or "unknown") pkgs)'
    )
    out = subprocess.run(
        [
            "nix",
            "eval",
            ".#nixosConfigurations.framework-desktop.config.home-manager.users.gus.home.packages",
            "--apply",
            expr,
            "--raw",
        ],
        cwd=ROOT,
        capture_output=True,
        text=True,
        check=True,
    ).stdout
    names = sorted({n for n in out.splitlines() if n and n not in HM_PLUMBING})
    return ", ".join(f"`{n}`" for n in names)


def render_programs() -> str:
    programs_dir = ROOT / "modules" / "_home" / "commons" / "programs"
    dev_dir = programs_dir / "dev"

    def names(directory: Path) -> list[str]:
        result = set()
        for p in directory.iterdir():
            if p.name.startswith("."):
                continue
            if p.is_dir():
                result.add(p.name)
            elif p.suffix == ".nix" and p.stem != "default":
                result.add(p.stem)
        return sorted(result)

    top = [n for n in names(programs_dir) if n != "dev"]
    dev = names(dev_dir)

    lines = ["**Programs**"]
    lines += [f"- {n}" for n in top]
    lines.append("")
    lines.append("**Dev tooling**")
    lines += [f"- {n}" for n in dev]
    return "\n".join(lines)


SECTIONS = {
    "inputs": render_inputs,
    "structure": render_structure,
    "hosts": render_hosts,
    "programs": render_programs,
    "packages": render_packages,
}


def main() -> int:
    text = README.read_text()
    original = text

    for name, render in SECTIONS.items():
        start = f"<!-- readme-gen:{name}:start -->"
        end = f"<!-- readme-gen:{name}:end -->"
        start_i = text.find(start)
        end_i = text.find(end)
        if start_i == -1 or end_i == -1:
            print(f"warning: markers for '{name}' not found in README.md, skipping", file=sys.stderr)
            continue
        content = render()
        text = text[: start_i + len(start)] + "\n" + content + "\n" + text[end_i:]

    if text != original:
        README.write_text(text)
        print("README.md updated")
    return 0


if __name__ == "__main__":
    sys.exit(main())
