{ config, lib, pkgs, ... }:

let
  cfg = config.features.vesktop;
in {
  options.features.vesktop = {
    enable = lib.mkEnableOption "Vesktop";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.vesktop ];
  };
}
