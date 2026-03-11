{ config, pkgs, lib, user, ... }:
let
  cfg = config.features.niri;
in {
  options.features.niri = {
    enable = lib.mkEnableOption "Niri"; 
  };

  config = lib.mkIf cfg.enable {
    programs.niri.enable = true;
    environment.systemPackages = [
      pkgs.xwayland-satellite
    ];
    home-manager.users.${user} = {
      home.file.".config/niri/config.kdl" = {
        source = ../config/niri.kdl;
      };
    };
  };
}
