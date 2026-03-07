{ config, pkgs, lib, user, ... }:
let
  cfg = config.features.hyprlock;
in {
  options.features.hyprlock = {
    enable = lib.mkEnableOption "Hyprlock"; 
  };

  config = lib.mkIf cfg.enable {
    programs.hyprlock.enable = true;
  };
}


