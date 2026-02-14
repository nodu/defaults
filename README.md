# defaults

Personal shell aliases, functions, and utilities for bash and zsh.

## Nix Flake

This repo is a Nix flake. You can import it into your NixOS or Home Manager configuration.

### Option 1: Home Manager Module (per-user)

Add the flake input:

```nix
# flake.nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    defaults.url = "github:nodu/defaults";
  };
}
```

Import and configure in your Home Manager config:

```nix
# home.nix
{ inputs, ... }:
{
  imports = [ inputs.defaults.homeManagerModules.default ];

  programs.defaults = {
    enable = true;
    basic.enable = true;      # navigation, archives, fzf, gpg, rsync
    git.enable = true;        # git aliases, worktree helpers
    network.enable = true;    # networking diagnostics (OSI layers)
  };
}
```

Sources scripts into both `programs.bash.initExtra` and `programs.zsh.initContent`, and adds grouped runtime dependencies to `home.packages`.

### Option 2: NixOS Module (system-wide)

Add the flake input:

```nix
# flake.nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    defaults.url = "github:nodu/defaults";
  };
}
```

Import and configure in your NixOS config:

```nix
# configuration.nix
{ inputs, ... }:
{
  imports = [ inputs.defaults.nixosModules.default ];

  programs.defaults = {
    enable = true;
    basic.enable = true;
    git.enable = true;
    network.enable = true;
  };
}
```

Sources scripts into `environment.interactiveShellInit` (all users, all interactive shells) and adds grouped runtime dependencies to `environment.systemPackages`.

### Module Options

| Option                             | Default | Description                                                                       |
| ---------------------------------- | ------- | --------------------------------------------------------------------------------- |
| `programs.defaults.enable`         | `false` | Master toggle                                                                     |
| `programs.defaults.basic.enable`   | `true`  | Shell aliases and functions (fzf, bat, rsync, gnupg, zip, etc.)                   |
| `programs.defaults.git.enable`     | `true`  | Git aliases, shortcuts, and worktree helpers (git, fzf)                           |
| `programs.defaults.network.enable` | `true`  | Networking diagnostics by OSI layer (nmap, traceroute, dnsutils, wireshark, etc.) |

All sub-options default to `true` when the module is enabled. Set any to `false` to skip that group.

## Manual Setup (without Nix)

### Temporary

```bash
curl https://raw.githubusercontent.com/nodu/defaults/master/basic.sh -o /tmp/basic.sh && source /tmp/basic.sh
curl https://raw.githubusercontent.com/nodu/defaults/master/network.sh -o /tmp/network.sh && source /tmp/network.sh
curl https://raw.githubusercontent.com/nodu/defaults/master/git.sh -o /tmp/git.sh && source /tmp/git.sh
```

### Permanent

```bash
mkdir -p ~/defaults
curl https://raw.githubusercontent.com/nodu/defaults/master/basic.sh -o ~/defaults/basic.sh
curl https://raw.githubusercontent.com/nodu/defaults/master/network.sh -o ~/defaults/network.sh
curl https://raw.githubusercontent.com/nodu/defaults/master/git.sh -o ~/defaults/git.sh
echo 'source ~/defaults/basic.sh' >> ~/.bashrc
echo 'source ~/defaults/network.sh' >> ~/.bashrc
echo 'source ~/defaults/git.sh' >> ~/.bashrc
```
