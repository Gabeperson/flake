{
  description = "Python flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        
        python_env = pkgs.python314.withPackages (ps: with ps; [
          requests
          numpy
        ]);
      in
      {
        devShells.default = pkgs.mkShell {
          # Use nativeBuildInputs for tools you need to run
          nativeBuildInputs = [
            python_env
          ];
        };
      }
    );
}
