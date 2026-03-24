
{
  config,
  pkgs,
  lib,
  user,
  ...
}:
let
  cfg = config.features.vscode;
in
{
  options.features.vscode = {
    enable = lib.mkEnableOption "vscode";
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.${user} = {
      programs.vscode = {
        enable = true;
        package = pkgs.vscode.fhsWithPackages (
          ps: with ps; [
            rustup
            zlib
            openssl.dev
            pkg-config
          ]   
        );
        profiles.default.extensions = with pkgs.vscode-extensions; [
          github.copilot
          redhat.java
          ms-python.python
          rust-lang.rust-analyzer
          biomejs.biome
          ms-vscode.cpptools-extension-pack
          tomoki1207.pdf
        ];
      };
    };
  };
}
