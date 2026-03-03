{
  description = "A very basic flake";

  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = { self, nixpkgs, home-manager, plasma-manager }:
    let
      user = "gabeperson";
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        gh-lenovo = lib.nixosSystem rec {
          inherit system;
          specialArgs = {
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
                imports = [ ./home.nix ];
              };
            }
          ];
        };
      };
      # homeManagerConfig = {
      #   gh-lenovo = home-manager.lib.homeManagerConfiguration {
      #     inherit system pkgs;         
      #     username = user;
      #     homeDirectory = "/home/${user}";
      #     configuration = {
      #       imports = [
              
      #       ];
      #     };
      #   };
      # };
    };
}
