{ config, lib, pkgs, user, ... }:

let
  cfg = config.features.zoom;
in {
  options.features.zoom = {
    enable = lib.mkEnableOption "Zoom";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.zoom-us
    ];
  };
}

