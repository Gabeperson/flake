{ config, pkgs, lib, user, ... }:
let
  cfg = config.features.hypridle;
in {
  options.features.hypridle = {
    enable = lib.mkEnableOption "Hypridle"; 
  };

  config = lib.mkIf cfg.enable {
    services.hypridle.enable = true;
  };
}


