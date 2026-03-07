{ config, pkgs, lib, ... }:
let
  cfg = config.features.niri;
in {
  options.features.niri = {
    enable = lib.mkEnableOption "Niri"; 
  };

  config = lib.mkIf cfg.enable {
    programs.niri.enable = true;
  };
}
