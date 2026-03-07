{ config, pkgs, lib, ... }:

let
  cfg = config.features.rust;
in {
  options.features.rust = {
    enable = lib.mkEnableOption "Rust";
  };
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.rustup ];
  };
}
