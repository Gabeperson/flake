{ config, lib, pkgs, user, ... }:

let
  cfg = config.features.firejail;
in {
  options.features.firejail = {
    enable = lib.mkEnableOption "firejail";
  };

  config = lib.mkIf cfg.enable {
    programs.firejail.enable = true;
  };
}

