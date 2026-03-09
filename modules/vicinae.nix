{ config, pkgs, lib, user, ... }:
let
  cfg = config.features.vicinae;
in {
  options.features.vicinae = {
    enable = lib.mkEnableOption "Vicinae"; 
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      # gnome extensions vicinae?
      pkgs.vicinae
    ];
    home-manager.users.${user} = {
      programs.vicinae = {
        enable = true;
        systemd.enable = true;
      };
    };
  };
}

