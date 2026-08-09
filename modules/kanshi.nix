{ config, lib, pkgs, user, inputs, ... }:
let
  cfg = config.features.kanshi;
in {
  options.features.kanshi = {
    enable = lib.mkEnableOption "Kanshi";
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.${user} = {
      services.kanshi.enable = true;
      home.file.".config/kanshi/config" = {
        source = ../config/kanshi;
      };
    };
  };
}


