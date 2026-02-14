{
  description = "Personal shell aliases, functions, and utilities for bash and zsh";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }: {
    homeManagerModules.default = import ./modules/home.nix { inherit self; };
    nixosModules.default = import ./modules/nixos.nix { inherit self; };
  };
}
