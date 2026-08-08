{
  description = "Flake setup";

  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    home-manager = {
      # url = "github:nix-community/home-manager";
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # plasma-manager = {
    #   url = "github:nix-community/plasma-manager";
    #   inputs.nixpkgs.follows = "nixpkgs";
    #   inputs.home-manager.follows = "home-manager";
    # };
    # awww.url = "git+https://codeberg.org/LGFae/awww";
    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, home-manager, ... }:
    let
      # system = "x86_64-linux";
      inherit (nixpkgs) lib;
      mkHost = {host, user ? "gabeperson" }:
        lib.nixosSystem {
          specialArgs = {inherit inputs host user;};
          modules = [
            ./hosts/common.nix
            ./hosts/${host}/configuration.nix
          ];
        };
    in {
      nixosConfigurations = {
        gh-lenovo = mkHost {
          host = "gh-lenovo";
        };
      };
    };
}
