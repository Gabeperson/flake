{ config, lib, pkgs, user, ... }:
let
  cfg = config.features.wl-clipboard;
in {
  options.features.wl-clipboard = {
    enable = lib.mkEnableOption "Wl-clipboard";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.wl-clipboard ];
  };
}
