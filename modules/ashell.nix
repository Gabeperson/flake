{ config, pkgs, lib, ... }:
let
  cfg = config.features.ashell;
in {
  options.features.ashell = {
    enable = lib.mkEnableOption "ashell bar"; 
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.ashell
    ];
  };
}

