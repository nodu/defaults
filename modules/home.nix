{ self }:

{ config, lib, pkgs, ... }:

let
  cfg = config.programs.defaults;

  scriptDir = self;

  basicDeps = with pkgs; [
    fzf
    bat
    rsync
    gnupg
    zip
    unzip
    unrar-free
    p7zip
  ];

  gitDeps = with pkgs; [
    git
    fzf
  ];

  networkDeps = with pkgs; [
    curl
    nmap
    traceroute
    dnsutils
    iproute2
    netcat-gnu
    wireshark-cli
    speedtest-cli
    inetutils
  ];

  scriptSources =
    (lib.optional cfg.basic.enable "source ${scriptDir}/basic.sh")
    ++ (lib.optional cfg.git.enable "source ${scriptDir}/git.sh")
    ++ (lib.optional cfg.network.enable "source ${scriptDir}/network.sh");

  initScript = builtins.concatStringsSep "\n" scriptSources;

in
{
  options.programs.defaults = {
    enable = lib.mkEnableOption "personal shell defaults (aliases, functions, utilities)";

    basic = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable basic shell aliases and functions (navigation, archives, fzf, gpg, rsync, etc.)";
      };
    };

    git = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable git aliases, shortcuts, and worktree helpers";
      };
    };

    network = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable networking diagnostic aliases and functions (organized by OSI layer)";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages =
      (lib.optionals cfg.basic.enable basicDeps)
      ++ (lib.optionals cfg.git.enable gitDeps)
      ++ (lib.optionals cfg.network.enable networkDeps);

    programs.bash.initExtra = initScript;
    programs.zsh.initExtra = initScript;
  };
}
