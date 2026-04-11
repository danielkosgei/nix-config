# shadow

[![Nix flake](https://img.shields.io/badge/nix-flake-informational?logo=nixos&logoColor=white)](https://nixos.wiki/wiki/Flakes)
[![NixOS unstable](https://img.shields.io/badge/nixpkgs-unstable-blue?logo=nixos)](https://github.com/NixOS/nixpkgs)

Personal [NixOS](https://nixos.org/) configuration as a **flake**, managed with [flake-parts](https://github.com/hercules-ci/flake-parts) and [import-tree](https://github.com/vic/import-tree). It defines a single host configuration named **`shadow`**.

This repository is opinionated and tailored to one machine. Use it as reference or a starting point after adjusting hardware, users, and paths—**not** as a drop-in install without reading the NixOS modules first.

## Features

- **Compositor**: [niri](https://github.com/YaLTeR/niri) on Wayland, wrapped via [nix-wrapper-modules](https://github.com/BirdeeHub/nix-wrapper-modules) (`myNiri`), with [xwayland-satellite](https://github.com/Supreeeme/xwayland-satellite) and session env tuned for Wayland clients
- **Display manager**: [ly](https://github.com/fairyglade/ly)
- **Audio**: PipeWire (Pulse + ALSA)
- **Browser**: [Zen Browser](https://github.com/zen-browser/desktop) wrapped with Firefox prefs (dark content / system theme)
- **Look and feel**: Gruvbox GTK theme and icons, Bibata cursors, dconf cursor defaults; GTK 3/4 `settings.ini` and session variables
- **Apps**: mpv, Zathura, lf, Spotify, fastfetch, and others via `modules/features/apps.nix`
- **Editor**: Neovim as default editor with [gruvbox-nvim](https://github.com/ellisonleao/gruvbox.nvim)
- **Terminal**: Kitty (system-wide `xdg/kitty/kitty.conf`)
- **lf**: Central config under `/etc/lf` with preview and clean scripts
- **Spotify**: [spicetify-nix](https://github.com/Gerg-L/spicetify-nix) (theme, marketplace, lyrics, extensions)
- **Boot**: GRUB with [DedSec theme](https://gitlab.com/VandalByte/dedsec-grub-theme)
- **Development**: Cursor (FHS), Node, Bun, Rust (rustup), Go, Python, PostgreSQL, Supabase CLI, ngrok, ripgrep, wasm-pack, and related tools
- **Shell bar**: Custom `myNoctalia` package from [noctalia-shell](https://github.com/BirdeeHub/nix-wrapper-modules) + `noctalia.json`

## Requirements

- [Nix](https://nixos.org/download.html) with flakes enabled (`experimental-features = nix-command flakes`)
- A NixOS system if you intend to apply `nixos-rebuild` (this flake exposes `nixosConfigurations.shadow`, not Home Manager standalone)

## Usage

From a clone of this repository:

```bash
nix flake show
```

Build the system closure (optional sanity check):

```bash
nix build .#nixosConfigurations.shadow.config.system.build.toplevel
```

Apply the configuration (will replace the running system config when you reboot or switch):

```bash
sudo nixos-rebuild switch --flake .#shadow
```

From the GitHub flake reference (replace with your fork if applicable):

```bash
sudo nixos-rebuild switch --flake github:danielkosgei/nix-config#shadow
```

Update flake inputs and regenerate the lockfile when you change inputs:

```bash
nix flake update
```

## Repository layout

```
.
├── flake.nix                 # inputs + flake-parts entrypoint
├── flake.lock
└── modules
    ├── parts.nix             # flake-parts: supported systems for perSystem
    ├── hosts/shadow
    │   ├── default.nix       # defines nixosConfigurations.shadow
    │   ├── configuration.nix   # main system module (imports + desktop stack)
    │   └── hardware.nix      # disk layout, platform (machine-specific)
    └── features
        ├── *.nix             # nixosModules + perSystem packages
        ├── kitty/kitty.conf
        ├── lf/               # lfrc, preview.sh, clean.sh
        └── noctalia.json
```

`import-tree` loads every `.nix` under `modules/` and merges their `flake.*` fragments, so new feature files are picked up automatically.

## Customization

Before reusing this flake on another host, review and adapt at least:

| Area | Where to look |
|------|----------------|
| Disks / ESP | `modules/hosts/shadow/hardware.nix` (`NIXROOT` / `NIXBOOT` labels) |
| Hostname / user / timezone | `modules/hosts/shadow/configuration.nix` |
| Git name and email | `modules/features/git.nix` |
| niri outputs, keybindings, wallpaper | `modules/features/niri.nix` |
| Noctalia settings | `modules/features/noctalia.json` |

Blindly running `nixos-rebuild switch` against foreign hardware definitions can make the system unbootable. Always compare with your own `hardware-configuration.nix` from the NixOS installer.

## Flake inputs

| Input | Role |
|-------|------|
| [nixpkgs](https://github.com/NixOS/nixpkgs) (`nixos-unstable`) | Package set and NixOS modules |
| [flake-parts](https://github.com/hercules-ci/flake-parts) | Flake structure |
| [import-tree](https://github.com/vic/import-tree) | Automatic module discovery |
| [nix-wrapper-modules](https://github.com/BirdeeHub/nix-wrapper-modules) | Wrapped niri + noctalia |
| [dedsec-grub-theme](https://gitlab.com/VandalByte/dedsec-grub-theme) | GRUB theme |
| [spicetify-nix](https://github.com/Gerg-L/spicetify-nix) | Spotify theming |
| [zen-browser-flake](https://github.com/youwen5/zen-browser-flake) | Zen Browser package |

Upstream projects and themes (e.g. Zathura colorscheme fetch) are credited in the respective Nix files.

## License

No `LICENSE` file is present in this repository. All rights are reserved unless you add an explicit license. If you fork or reuse snippets, add your own license as appropriate.
