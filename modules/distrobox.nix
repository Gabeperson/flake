{ config, lib, pkgs, user, inputs, ... }:
let
  cfg = config.features.distrobox;
in {
  options.features.distrobox = {
    enable = lib.mkEnableOption "Distrobox";
  };

  config = lib.mkIf cfg.enable {
    virtualisation.podman = {
      enable = true;
      dockerCompat = true;
    };
    environment.systemPackages = [
      pkgs.distrobox
    ];
  };
}


