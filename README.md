# NixOS Configuration

A modular, declarative NixOS configuration repository for managing multiple hosts using Nix Flakes.

## Features

- **Nix Flakes** — reproducible system configurations.
- **Modular profiles** — reusable configuration across hosts.
- **Automatic host discovery** — host configurations generated from directories under `hosts/`.
- **Disko** — declarative disk partitioning and filesystem configuration.
- **LUKS encryption** — encrypted storage for supported host configurations.
- **SSH** — remote administration with public-key authentication.

## Repository Structure

```text
.
├── flake.nix
├── lib/
│   └── generators.nix
├── profiles/
└── hosts/
    ├── host-a/
    │   ├── default.nix
    │   └── disk-config.nix
    └── host-b/
        ├── default.nix
        └── disk-config.nix
```

## Usage

Inspect and validate configurations:

```bash
nix flake show
nix flake check --no-build
```

Evaluate a specific host:

```bash
nix eval .#nixosConfigurations.HOSTNAME.config.networking.hostName
```

Apply configuration updates on a host:

```bash
sudo nixos-rebuild switch --flake .#HOSTNAME
```

Replace `HOSTNAME` with the corresponding directory name under `hosts/`.