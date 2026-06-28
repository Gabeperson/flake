{ config, lib, pkgs, user, ... }:
let
  cfg = config.features.r2modman;
in {
  options.features.r2modman = {
    enable = lib.mkEnableOption "R2modman";
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.${user} = {
      home.packages = [ pkgs.r2modman ];
    };
  };
}

