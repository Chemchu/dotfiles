# My dotfiles!

Welcome! If you are reading this, you somehow stumbled into my personal dotfiles
repository. Here I store all the stupid stuff I do to my systems to make them
work the way I want.

If you need help, feel free to open an issue. Just keep in mind that my
configurations are designed to solve my problems with my specific hardware. I'll
help as much as I can, but no promises.

> PD: These docs are a guide for future me. I know I'm going to be reading this
> constantly

---

## What is this?

This is a **NixOS + Home Manager + Flakes** setup. Everything is declarative and
(ideally) reproducible. If you break it, you can always roll back. That's the
beauty of Nix.

The repo is structured around two layers:

- **NixOS** — system-level config (bootloader, hardware, kernel, services)
- **Home Manager** — user-level config (programs, dotfiles, dev tools, theming)

Both layers, plus the flake-parts/import-tree glue that wires them together,
live under a single `modules/` tree. Directories prefixed with `_` (like
`modules/_home/`) hold plain NixOS/home-manager modules on purpose — they're
intentionally *not* auto-imported by `import-tree` (it skips any path
containing `/_`), and are instead pulled in explicitly by a sibling file, so
that a plain module never gets misinterpreted as a flake-parts module.

---

## Structure

The tree below is generated — see [Keeping this file honest](#keeping-this-file-honest).

<!-- readme-gen:structure:start -->
```
dotfiles/
├── modules/
│   ├── _home/
│   │   ├── commons/
│   │   │   ├── programs/
│   │   │   │   ├── dev/
│   │   │   │   │   ├── nix/
│   │   │   │   │   │   ├── default.nix
│   │   │   │   │   │   └── review.sh
│   │   │   │   │   ├── arduino.nix
│   │   │   │   │   ├── bevy.nix
│   │   │   │   │   ├── bun.nix
│   │   │   │   │   ├── clang.nix
│   │   │   │   │   ├── default.nix
│   │   │   │   │   ├── direnv.nix
│   │   │   │   │   ├── github-token.nix
│   │   │   │   │   ├── microcontroller.nix
│   │   │   │   │   ├── node.nix
│   │   │   │   │   ├── python.nix
│   │   │   │   │   ├── rust.nix
│   │   │   │   │   └── vulkan.nix
│   │   │   │   ├── direnv/
│   │   │   │   │   └── default.nix
│   │   │   │   ├── fastfetch/
│   │   │   │   │   ├── config.jsonc
│   │   │   │   │   ├── default.nix
│   │   │   │   │   └── fastfetch_logo.txt
│   │   │   │   ├── ghostty/
│   │   │   │   │   └── default.nix
│   │   │   │   ├── git/
│   │   │   │   │   └── default.nix
│   │   │   │   ├── heroic_games/
│   │   │   │   │   └── default.nix
│   │   │   │   ├── llama-cpp/
│   │   │   │   │   └── default.nix
│   │   │   │   ├── mouse/
│   │   │   │   │   └── default.nix
│   │   │   │   ├── nvf/
│   │   │   │   │   ├── debugger/
│   │   │   │   │   │   ├── default.nix
│   │   │   │   │   │   └── lldb.nix
│   │   │   │   │   └── default.nix
│   │   │   │   ├── obs/
│   │   │   │   │   └── default.nix
│   │   │   │   ├── oxide/
│   │   │   │   │   └── default.nix
│   │   │   │   ├── steam/
│   │   │   │   │   └── default.nix
│   │   │   │   ├── yazi/
│   │   │   │   │   └── default.nix
│   │   │   │   ├── zellij/
│   │   │   │   │   └── default.nix
│   │   │   │   ├── zsh/
│   │   │   │   │   └── default.nix
│   │   │   │   └── default.nix
│   │   │   ├── wallpapers/
│   │   │   │   └── default.nix
│   │   │   └── default.nix
│   │   ├── niri/
│   │   │   └── default.nix
│   │   └── default.nix
│   ├── features/
│   │   ├── niri/
│   │   │   ├── nixos.nix
│   │   │   └── packages.nix
│   │   └── noctalia/
│   │       ├── noctalia.json
│   │       └── packages.nix
│   ├── hosts/
│   │   └── framework-desktop/
│   │       ├── _hardware-configuration.nix
│   │       ├── configuration.nix
│   │       └── hardware.nix
│   ├── default.nix
│   └── home.nix
├── nvim/
│   ├── config.nix
│   ├── debugger.nix
│   └── flake.nix
├── scripts/
│   └── update-readme.py
├── LICENSE
├── README.md
├── flake.lock
└── flake.nix
```
<!-- readme-gen:structure:end -->

---

## My machines

<!-- readme-gen:hosts:start -->
- **framework-desktop** (with a dedicated hardware profile)
<!-- readme-gen:hosts:end -->

### framework-desktop

My daily driver. AMD desktop, AMD GPU (amdgpu driver) — no Intel, no NVIDIA.

- **WM**: Niri (Wayland compositor)
- **Shell**: Noctalia (Niri shell for app launcher and system bar)
- **Terminal**: Ghostty
- **Login**: greetd, auto-logs into niri (tuigreet only shows up as a fallback)
- **Shell**: Zsh + oh-my-zsh

---

## Prerequisites

You need **NixOS** installed with **flakes enabled**. That's it.

To enable flakes, add this to your `configuration.nix`:

```nix
nix.settings.experimental-features = [ "nix-command" "flakes" ];
```

---

## Installing

Clone the repo:

```console
$ git clone https://github.com/Chemchu/dotfiles ~/dotfiles
$ cd ~/dotfiles
```

Apply the system config (as root). Home Manager is wired in as a NixOS module
(`home-manager.users.gus`), so this one command builds both layers — there is
no separate standalone `home-manager switch` step:

```console
# nixos-rebuild switch --flake .#framework-desktop
```

---

## What's configured

Dependency versions and the program/feature list below are generated from the
actual flake and repo contents — see
[Keeping this file honest](#keeping-this-file-honest).

### Flake inputs

<!-- readme-gen:inputs:start -->
| Input | Source | Pinned |
| --- | --- | --- |
| devshell | github:numtide/devshell | default branch @ a67c0f8 |
| flake-parts | github:hercules-ci/flake-parts | default branch @ 31729ca |
| home-manager | github:nix-community/home-manager | default branch @ 1790312 |
| import-tree | github:vic/import-tree | default branch @ eb1b52e |
| llama-cpp-src | github:PrismML-Eng/llama.cpp | default branch @ 9a9394a |
| nixpkgs | github:nixos/nixpkgs | nixos-unstable @ e554fab |
| nvim | local path (`./nvim`) | - |
| rust-overlay | github:oxalica/rust-overlay | default branch @ 26a71e6 |
| wrapper-modules | github:BirdeeHub/nix-wrapper-modules | default branch @ 1db3c11 |
| zen-browser | github:youwen5/zen-browser-flake | default branch @ 9c1767f |
<!-- readme-gen:inputs:end -->

### Home Manager modules

Programs with their own dedicated Nix config (`modules/_home/commons/programs/`):

<!-- readme-gen:programs:start -->
**Programs**
- direnv
- fastfetch
- ghostty
- git
- heroic_games
- llama-cpp
- mouse
- nvf
- obs
- oxide
- steam
- yazi
- zellij
- zsh

**Dev tooling**
- arduino
- bevy
- bun
- clang
- direnv
- github-token
- microcontroller
- nix
- node
- python
- rust
- vulkan
<!-- readme-gen:programs:end -->

### Installed packages

Every package actually resolved onto `gus`'s home-manager profile, straight
from evaluating the flake — this list can't drift out of sync with reality:

<!-- readme-gen:packages:start -->
`alejandra`, `alsa-lib`, `arduino-cli`, `arduino-language-server`, `aseprite`, `bacon`, `bat`, `bind`, `bottom`, `btop`, `bun`, `clang-wrapper`, `claude-code`, `cmake`, `devenv`, `direnv`, `discord`, `dnslookup`, `du-dust`, `dua`, `dysk`, `everforest-cursors`, `eza`, `fastfetch`, `fd`, `feh`, `ffmpeg`, `flyctl`, `fzf`, `gamescope`, `gcc-arm-embedded`, `ghostty`, `gnumake`, `heroic`, `htop`, `jq`, `libx11`, `libxcursor`, `libxi`, `libxkbcommon`, `libxrandr`, `llama-cpp-latest`, `lm-sensors`, `lsof`, `luarocks-packages-updater`, `mangohud`, `mpv-with-scripts`, `ncdu`, `nix-init`, `nix-output-monitor`, `nix-tree`, `nix-update`, `nix-zsh-completions`, `nixpkgs-review`, `nixpkgs-review-tmux`, `nmap`, `nodejs`, `nvf-reference-manpage`, `nvf-with-helpers`, `oh-my-zsh`, `opencode`, `openconnect`, `pciutils`, `pkg-config-wrapper`, `procs`, `psmisc`, `python3`, `random-mouse`, `ripgrep`, `shaderc`, `shared-mime-info`, `spotify`, `sshfs-fuse`, `statix`, `steam`, `stlink`, `systemd-minimal-libs`, `tauri`, `tcpdump`, `thc-hydra`, `tlrc`, `unzip`, `uutils-coreutils`, `vim-plugins-updater`, `vulkan-loader`, `wayland`, `wl-clipboard`, `wrapped-obs-studio-32.2.2`, `yazi`, `zellij`, `zoxide`, `zsh`
<!-- readme-gen:packages:end -->

---

## Keeping this file honest

The sections above marked with an HTML comment pair
(`<!-- readme-gen:*:start/end -->`) are generated by
[`scripts/update-readme.py`](scripts/update-readme.py) from the flake lock
file and the `modules/` tree — not hand-maintained. Everything else on this
page (the prose, the HOWTOs below) is regular hand-written documentation.

A git hook regenerates those sections before every commit:

```console
$ git config core.hooksPath .githooks   # already done automatically via .envrc
```

If a commit touches something that changes a generated section,
`.githooks/pre-commit` regenerates `README.md`, stages it, and aborts the
commit once so you can review the diff before committing again. You can also
run it by hand:

```console
$ python3 scripts/update-readme.py
```

---

## Fingerprint reader

`framework-desktop` has a Goodix fingerprint sensor. It's configured via `fprintd`
with the TOD (Touch OD) driver (`libfprint-2-tod1-goodix`). Polkit is set up to
allow wheel users to enroll without needing sudo.

### Enrolling a finger

```console
$ fprintd-enroll
```

By default this enrolls the right index finger. To enroll a specific finger:

```console
$ fprintd-enroll -f <finger>
```

Valid finger names: `left-thumb`, `left-index-finger`, `left-middle-finger`,
`left-ring-finger`, `left-little-finger` and the same for `right-*`.

Follow the prompts — it'll ask you to lift and place the same finger several
times. Once done, you should see:

```
Enroll result: enroll-completed
```

### Listing enrolled fingers

```console
$ fprintd-list $USER
```

### Deleting enrolled fingers

```console
$ fprintd-delete $USER
```

This deletes all enrolled fingers for the user. There's no per-finger delete in
the CLI, so if you want to redo one finger you have to redo all of them.

### Verifying it works

```console
$ fprintd-verify
```

It'll ask you to swipe — if it returns `verify-match` you're good.

---

## Connecting to Bluetooth

Bluez ships with `bluetoothctl`, which makes pairing straightforward.

Start the interactive shell:

```console
$ bluetoothctl
```

Set up the agent and start scanning:

```console
[bluetooth]# agent on
[bluetooth]# default-agent
[bluetooth]# scan on
```

Find your device in the output and copy its MAC address, then pair:

```console
[bluetooth]# pair <MAC address>
[agent] Confirm passkey 687331 (yes/no): yes
```

Stop scanning and exit:

```console
[bluetooth]# scan off
[bluetooth]# exit
```

---

## Setting up WiFi

Use `nmtui` for a simple TUI interface. Ethernet? Just plug it in.

```console
$ nmtui
```

---

## License

MIT — see [LICENSE](LICENSE).
