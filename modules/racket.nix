{ config, lib, pkgs, user, inputs, ... }:
let
  cfg = config.features.racket;
in {
  options.features.racket = {
    enable = lib.mkEnableOption "racket";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.racket
    ];
  };
}


