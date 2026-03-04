{ config, lib, pkgs, ... }:

let
  cfg = config.features.printing;
in {
  options.features.printing = {
    enable = lib.mkEnableOption "Printing";
  };

  config = lib.mkIf cfg.enable {
    services.printing.enable = true;
  };
}

