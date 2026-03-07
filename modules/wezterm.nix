{ config, pkgs, lib, user, ... }:
let
  cfg = config.features.wezterm;
in {
  options.features.wezterm = {
    enable = lib.mkEnableOption "Wezterm"; 
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.wezterm
    ];
  };
}


