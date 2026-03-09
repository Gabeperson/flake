{ config, pkgs, lib, user, ... }:
let
  cfg = config.features.swaync;
in {
  options.features.swaync = {
    enable = lib.mkEnableOption "Swaync"; 
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.swaynotificationcenter
    ];
    home-manager.users.${user} = {
      services.swaync = {
        enable = true;
      };
    };
  };
}


