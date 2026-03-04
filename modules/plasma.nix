{ config, lib, pkgs, user, ... }:

let
  cfg = config.features.plasma;
  bibata = config.features.bibata;
in {
  options.features.plasma = {
    enable = lib.mkEnableOption "KDE Plasma";
  };

  config = lib.mkIf cfg.enable {
    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;
    users.users.${user}.packages = [ pkgs.kdePackages.kate ];
    environment = {
      variables = {
        QT_QPA_PLATFORM="wayland";
      };
      sessionVariables = {
        NIXOS_OZONE_WL = "1";
      };
    };
  };
}

