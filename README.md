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

---

## Structure

```
dotfiles/
├── flake.nix               # Entry point — inputs and outputs
├── flake.lock              # Locked dependency versions
├── nixos/
│   └── hosts/
│       └── framework13/    # Framework 13 system config
├── home-manager/
│   ├── commons/            # Shared program configs (used by all hosts)
│   │   └── programs/       # Per-program Nix configs
│   └── niri/               # Niri-specific home config
└── modules/
    ├── features/           # Optional features (Niri, Noctalia, etc.)
    └── hosts/              # Host-specific module imports
```

---

## My machines

### Framework 13

My daily driver. Framework 13 notebook with an AMD Ryzen 5 7640U. No Intel, no
NVIDIA — exactly how I like it.

- **WM**: Niri (Wayland compositor)
- **Shell**: Noctalia (Niri shell for app launcher and system bar)
- **Terminal**: Kitty
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

Apply the NixOS system config (as root):

```console
# nixos-rebuild switch --flake .#framework13
```

Apply the Home Manager config:

```console
$ home-manager switch --flake .#gus
```

---

## What's configured

### Desktop

- **Niri** — Wayland compositor, replaces Hyprland
- **Noctalia** — Niri shell with custom bar config
- **Kitty** — GPU-accelerated terminal (Wayland-native)
- **Zellij** — Terminal multiplexer
- **Everforest cursors** — Cursor theme

### Editors

- **Neovim** — Configured with [nvf](https://github.com/NotAShelf/nvf)
  (declarative Neovim in Nix, no Lua required)
  - Theme: One Dark
  - LSP for: Rust, Python, JavaScript/TypeScript, Nix, Go, and more
  - Plugins: Telescope, Oil.nvim, Undotree, DAP debugging, git integration
  - Run it with `nvim` or `vim` (alias)
- **Zed** — Modern editor with vim mode and Claude AI integration

### Shell & CLI

- **Zsh** + oh-my-zsh (git + direnv plugins)
- **Zoxide** + **eza** — Better `cd` and `ls`
- **lf** — Terminal file manager with custom keybindings and previewer
- **Fastfetch** — System info display
- **bat, ripgrep, fd, dust, bottom, dua, dysk, procs** — Rust-powered CLI tools

### Development

| Tool    | Details                                               |
| ------- | ----------------------------------------------------- |
| Rust    | Stable toolchain + cargo-tauri, bacon                 |
| Node.js | v22                                                   |
| Python  | With ML stack (torch, numpy, matplotlib, tensorboard) |
| Bun     | JavaScript runtime/bundler                            |
| C/C++   | clang toolchain                                       |
| Nix     | nix-tree, nix-update, nixpkgs-review, and more        |
| Git     | With LFS support                                      |
| direnv  | Per-project dev environments                          |
| Docker  | Containerization                                      |

### Media & Gaming

- **Steam** with Gamescope
- **OBS Studio** — wlrobs, background-removal, pipewire-audio plugins
- **Spotify** (Wayland flags applied)
- **Guitarix** — Guitar audio processing via PipeWire
- **Blender** — 3D modeling
- **Godot 4** — Game engine
- **Discord**

### Browsers

- Zen Browser (primary)
- Google Chrome
- Firefox

---

## Fingerprint reader

The Framework 13 has a Goodix fingerprint sensor. It's configured via `fprintd` with the TOD (Touch OD) driver (`libfprint-2-tod1-goodix`). Polkit is set up to allow wheel users to enroll without needing sudo.

### Enrolling a finger

```console
$ fprintd-enroll
```

By default this enrolls the right index finger. To enroll a specific finger:

```console
$ fprintd-enroll -f <finger>
```

Valid finger names: `left-thumb`, `left-index-finger`, `left-middle-finger`, `left-ring-finger`, `left-little-finger` and the same for `right-*`.

Follow the prompts — it'll ask you to lift and place the same finger several times. Once done, you should see:

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

This deletes all enrolled fingers for the user. There's no per-finger delete in the CLI, so if you want to redo one finger you have to redo all of them.

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
