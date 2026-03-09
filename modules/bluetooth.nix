{ config, lib, pkgs, user, ... }:

let
  cfg = config.features.bluetooth;
in {
  options.features.bluetooth = {
    enable = lib.mkEnableOption "Bluetooth";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.bluetui
    ];
    hardware.bluetooth.enable = true;
    hardware.bluetooth.settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        # Show battery charge
        Experimental = true;
      };
    };
    home-manager.users.${user} = {
      services.mpris-proxy.enable = true;
    };
  };
}
