{ config, pkgs, lib, user, ... }:
let
  cfg = config.features.steam;
in {
  options.features.steam = {
    enable = lib.mkEnableOption "steam"; 
  };

  config = lib.mkIf cfg.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
    };
  };
}


