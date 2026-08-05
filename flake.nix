{
  description = "A very basic flake";

  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    home-manager = {
      # url = "github:nix-community/home-manager";
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    awww.url = "git+https://codeberg.org/LGFae/awww";
    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, home-manager, plasma-manager, ... }:
    let
      user = "gabeperson";
      # system = "x86_64-linux";
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        gh-lenovo = lib.nixosSystem rec {
          # inherit system;
          specialArgs = {
            inherit inputs;
            inherit user;
            host = "gh-lenovo";
          };
          modules = [
            ./configuration.nix
            home-manager.nixosModules.home-manager {
              home-manager.extraSpecialArgs = specialArgs;
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.sharedModules = [ plasma-manager.homeModules.plasma-manager ];
              home-manager.users.${user} = {
                home.username = user;  
                home.homeDirectory = "/home/${user}";
                home.stateVersion = "25.11";
              };
              home-manager.backupFileExtension = "hmbackup";
            }
          ];
        };
      };
    };
}
