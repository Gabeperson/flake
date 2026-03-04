{ config, lib, pkgs, ... }:

let
  cfg = config.features.bibata;
in {
  options.features.bibata = {
    enable = lib.mkEnableOption "Bibata Cursor";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.bibata-cursors ];
  };
}
