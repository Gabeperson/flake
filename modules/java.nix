{ config, lib, pkgs, ... }:

let
  cfg = config.features.java;
in {
  options.features.java = {
    enable = lib.mkEnableOption "Java";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.jdk 
    ];
  };
}
